//
//  WeatherViewModel.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation

class WeatherViewModel : ObservableObject{
    
    @Published private(set) var model: WeatherModel  = WeatherModel(cities: ["Venice", "Paris", "Warsaw", "Cracow", "Berlin", "London","Barcelona"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord){
        model.refresh(record: record)
    }
}
