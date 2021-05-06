//
//  WeatherModel.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation

struct WeatherModel{
    
    var records: Array<WeatherRecord> = []
    
    init(cities: Array<String>){
        records = Array<WeatherRecord>()
        for city in cities{
            records.append(WeatherRecord(cityName: city))
        }
    }
    
    struct WeatherRecord: Identifiable, Equatable {
        var id : UUID = UUID()
        var cityName: String
        var weatherState: String = "Clear"
        var temperature: Float = Float.random(in: -10.0 ... 30.0)
        var humidity : Float = Float.random(in: 0 ... 100)
        var windSpeed: Float = Float.random(in: 0 ... 20)
        var windDirection: Float = Float.random(in: 0...360)
    }
    
    mutating func refresh(record: WeatherRecord){
        records[records.firstIndex(of: record) ?? 0].temperature = Float.random(in: -10.0 ... 30.0)
    }
}
