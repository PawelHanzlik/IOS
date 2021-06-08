//
//  WeatherViewModel.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation
import SwiftUI
import Combine

class WeatherViewModel : NSObject, ObservableObject{
    
    // Wszystkie stałe wartości parametrów
    var cornerRadius: Float = 25.0
    var height: Float = 75.0
    var scale: Float = 0.7
    var width: Float = 150.0
    
    // Przekazuję także różne stany pogody do modelu, gdzie jest on losowany.
//    @Published private(set) var model: WeatherModel  = WeatherModel(cities: ["Venice", "Paris", "Warsaw", "Cracow", "Berlin", "London","Barcelona"],states: ["Clear", "Snow", "Heavy Rain", "Heavy Cloud", "Light Cloud", "Showers", "Thunderstorm"])
    
    @Published private(set) var model: WeatherModel  = WeatherModel(cities: ["2459115","2442047","4118","44418","615702","2487956"],states: ["Clear", "Snow", "Heavy Rain", "Heavy Cloud", "Light Cloud", "Showers", "Thunderstorm"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    private var weatherFetcher: WeatherFetcher
    private var cancellables: Set<AnyCancellable> = []
    
    override init(){
        weatherFetcher = WeatherFetcher()
        super.init()
        for record in records{
            fetch(forId: record.woeId, record: record)
        }
    }
    
    func fetch(forId woeId:String, record: WeatherModel.WeatherRecord){
        weatherFetcher.forecast(forId: woeId).sink(receiveCompletion: {completion in}, receiveValue: {[self]response in self.model.refresh(woeId: woeId, response: response, record: record)}).store(in: &cancellables)
    }
    
    func refresh(record: WeatherModel.WeatherRecord){
        model.refresh(record: record)
    }
    
    func refresh(woeId: String, response: WeatherResponse, record: WeatherModel.WeatherRecord){
        model.refresh(woeId: woeId, response: response, record: record)
    }
    
    // Metoda zwracająca stan pogody danego modelu
    func getWeatherState(record: WeatherModel.WeatherRecord) -> String{
        model.getWeatherState(record: record)
    }
    
}

struct WeatherViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
