//
//  ContentView.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(viewModel.records){
                    record in WeatherRecordView(record: record, viewModel: viewModel)
                }
            }.padding()
        }
    }
}

struct WeatherRecordView: View {
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    @State var displayParam: String = "Temperature"
    // Wspórzędne dla Bielska- Bialej
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.82, longitude: 19.04), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    @State var sheet = false
    @State private var places: [Place] = [Place(coordinate: .init(latitude: 49.82, longitude: 19.04))]
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: CGFloat(viewModel.cornerRadius))
                .stroke().frame(height : CGFloat(viewModel.height)) // ustawienie wysokości prostokątu na stałą wartość
            HStack{
                // Dopasowanie wysokości ikonki pogody do wysokości prostokąta jako 0.7 jego wysokości oraz wyrównanie jej do lewej strony
                GeometryReader{geometry in
                    Text(viewModel.getWeatherState(record: record)).font(.system(size : CGFloat(viewModel.scale) * geometry.size.height)).frame(alignment: .leading)}
                // Wyrównanie obu tekstów do lewej strony oraz wyświetlanie odpowiedniego parametru rekordu w zależności od wartości zmiennej displayParam 
                VStack(alignment: .leading){
                    Text(record.cityName)
                    switch displayParam{
                    case "Temperature": Text("Temperature: \(String(format: "%.1f",record.temperature))℃").font(.caption).onTapGesture {displayParam = "Humidity"}
                    case "Humidity": Text("Humidity: \(String(format: "%.1f",record.humidity))%").font(.caption).onTapGesture {displayParam = "WindSpeed"}
                    case "WindSpeed": Text("WindSpeed:\(String(format: "%.1f",record.windSpeed))m/s").font(.caption).onTapGesture {displayParam = "WindDirection"}
                    case "WindDirection": Text("WindDirection:\(String(format: "%.1f",record.windDirection))º").font(.caption).onTapGesture {displayParam = "Temperature"}
                    default: Text("Temperature: \(String(format: "%.1f",record.temperature))℃").font(.caption).onTapGesture {displayParam = "Humidity"}
                    }
                }.frame(width: CGFloat(viewModel.width), alignment: .leading) // Ustawienie szerokości stacka na stałą wartość i wyrównanie go do lewej
                Text("🔄").font(.largeTitle).onTapGesture {
                    viewModel.fetch(forId: record.woeId, record: record)
                }.frame(alignment: .trailing) // Wyrównanie ikony refresh do prawej strony
                Text("🌍").font(.largeTitle).onTapGesture {
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: record.latitude, longitude: record.longitude), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
                    sheet = true
                }.frame(alignment: .trailing)
                .sheet(isPresented: $sheet, content: {Map(coordinateRegion: $region, annotationItems: [Place(coordinate: .init(latitude: record.latitude, longitude: record.longitude))]){
                    place in MapPin(coordinate: place.coordinate)
                }.padding()})
            }
        }
    }
}

struct Place: Identifiable{
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
