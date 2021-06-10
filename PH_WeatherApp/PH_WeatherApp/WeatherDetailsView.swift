//
//  WeatherDetailsView.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 10/06/2021.
//

import SwiftUI

struct WeatherDetailsView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let record: WeatherModel.WeatherRecord
    
    var body: some View {

        ZStack{
            RoundedRectangle(cornerRadius: CGFloat(viewModel.cornerRadius))
                .stroke().frame(height : CGFloat(7*viewModel.height)) // ustawienie wysokości prostokątu na stałą wartość
            HStack{
                GeometryReader{geometry in
                    Text(viewModel.getWeatherState(record: record)).font(.system(size : CGFloat(0.3*viewModel.scale) * geometry.size.height)).frame(alignment: .leading)}

                GeometryReader{geometry in
                    Text("\(String(format: "%.0f",record.temperature))℃").font(.system(size : CGFloat(0.15*viewModel.scale) * geometry.size.height)).frame(alignment: .trailing)}

            }
            
            VStack{
                Text("City Name: \(record.cityName)")
                Text("WOEID: \(record.woeId)")
                Text("Latitude: \(record.latitude)")
                Text("Longitude: \(record.longitude)")
                Text("Weather State: \(record.weatherState)")
                Text("Humidity: \(record.humidity)")
                Text("Wind Speed: \(record.windSpeed)")
                Text("Wind Direction: \(record.windDirection)")
            }
        }
    }
    
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(viewModel: WeatherViewModel(),record: WeatherModel.WeatherRecord(weatherState: "", woeId: ""))
    }
}
