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
        // Dla każdego miasta zostaje losowany stan pogody
        for city in cities{
            records.append(WeatherRecord(weatherState: states.randomElement() ?? "Clear", woeId: city))
        }
    }
    
    struct WeatherRecord: Identifiable, Equatable {
        var id : UUID = UUID()
        var cityName: String = "default"
        var weatherState: String
        var temperature: Float = Float.random(in: -10.0 ... 30.0)
        var humidity : Float = Float.random(in: 0 ... 100)
        var windSpeed: Float = Float.random(in: 0 ... 20)
        var windDirection: Float = Float.random(in: 0...360)
        var woeId: String
        
    }
    
    // Funkcja zmieniająca każdy parametr rekordu po wciśnięciu przycisku refresh
    mutating func refresh(record: WeatherRecord){
        let i = records.firstIndex(of: record) ?? 0
        records[i].temperature = Float.random(in: -10.0 ... 30.0)
        records[i].humidity = Float.random(in: 0 ... 100)
        records[i].windSpeed = Float.random(in: 0 ... 20)
        records[i].windDirection = Float.random(in: 0...360)
        records[i].weatherState = self.states.randomElement() ?? "Clear"
    }
    
    
    mutating func refresh(woeId: String, response: WeatherResponse, record: WeatherRecord){
        let i = records.firstIndex(of: record) ?? 0
        records[i].cityName = response.title
        records[i].temperature = Float(response.consolidatedWeather[0].theTemp)
        records[i].humidity = Float(response.consolidatedWeather[0].humidity)
        records[i].windSpeed = Float(response.consolidatedWeather[0].windSpeed)
        records[i].windDirection = Float(response.consolidatedWeather[0].windDirection)
        records[i].weatherState = response.consolidatedWeather[0].weatherStateName
    }
    
    
    // Funkcja zwracająca ikonkę pogody w zależności od stanu pogody w rekordzie
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
