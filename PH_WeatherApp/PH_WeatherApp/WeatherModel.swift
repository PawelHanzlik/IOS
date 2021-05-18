//
//  WeatherModel.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation

struct WeatherModel{
    
    var records: Array<WeatherRecord> = []
    
    init(cities: Array<String>, states: Array<String>){
        records = Array<WeatherRecord>()
        for city in cities{
            records.append(WeatherRecord(cityName: city, weatherState: states.randomElement() ?? "Clear"))
        }
    }
    
    struct WeatherRecord: Identifiable, Equatable {
        var id : UUID = UUID()
        var cityName: String
        var weatherState: String
        var temperature: Float = Float.random(in: -10.0 ... 30.0)
        var humidity : Float = Float.random(in: 0 ... 100)
        var windSpeed: Float = Float.random(in: 0 ... 20)
        var windDirection: Float = Float.random(in: 0...360)
    }
    
    mutating func refresh(record: WeatherRecord){
        records[records.firstIndex(of: record) ?? 0].temperature = Float.random(in: -10.0 ... 30.0)
        records[records.firstIndex(of: record) ?? 0].humidity = Float.random(in: 0 ... 100)
        records[records.firstIndex(of: record) ?? 0].windSpeed = Float.random(in: 0 ... 20)
        records[records.firstIndex(of: record) ?? 0].windDirection = Float.random(in: 0...360)
    }
    
    func getWeatherState(record: WeatherRecord) -> String{
        switch record.weatherState{
        case "Clear" : return "☀️"
        case "Snow" : return "🌨"
        case "Heavy Rain" : return "🌧"
        case "Heavy Cloud" : return "☁️"
        case "Light Cloud" : return "🌤"
        case "Showers" : return "🌦"
        case "Thunderstorm" : return "🌩"
        default: return "☀️"
        }
    }
    
}
