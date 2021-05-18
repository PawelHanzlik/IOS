//
//  WeatherModel.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation

struct WeatherModel{
    
    var records: Array<WeatherRecord> = []
    var states: Array<String> = []
    
    init(cities: Array<String>, states: Array<String>){
        records = Array<WeatherRecord>()
        self.states = states
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
        let i = records.firstIndex(of: record) ?? 0
        records[i].temperature = Float.random(in: -10.0 ... 30.0)
        records[i].humidity = Float.random(in: 0 ... 100)
        records[i].windSpeed = Float.random(in: 0 ... 20)
        records[i].windDirection = Float.random(in: 0...360)
        records[i].weatherState = self.states.randomElement() ?? "Clear"
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
