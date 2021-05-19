//
//  WeatherViewModel.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation
import SwiftUI

class WeatherViewModel : ObservableObject{
    
    var cornerRadius: Float = 25.0
    var height: Float = 75.0
    var scale: Float = 0.7
    var width: Float = 150.0
    
    @Published private(set) var model: WeatherModel  = WeatherModel(cities: ["Venice", "Paris", "Warsaw", "Cracow", "Berlin", "London","Barcelona"],states: ["Clear", "Snow", "Heavy Rain", "Heavy Cloud", "Light Cloud", "Showers", "Thunderstorm"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord){
        model.refresh(record: record)
    }
    
    func getWeatherState(record: WeatherModel.WeatherRecord) -> String{
        model.getWeatherState(record: record)
    }
    
}

struct WeatherViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
