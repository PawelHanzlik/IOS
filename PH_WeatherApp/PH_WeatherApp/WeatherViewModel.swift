//
//  WeatherViewModel.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import MapKit

class WeatherViewModel : NSObject, ObservableObject, CLLocationManagerDelegate{
    
    // Wszystkie stałe wartości parametrów
    var cornerRadius: Float = 25.0
    var height: Float = 75.0
    var scale: Float = 0.7
    var width: Float = 120.0
    
    // Przekazuję także różne stany pogody do modelu, gdzie jest on losowany.
//    @Published private(set) var model: WeatherModel  = WeatherModel(cities: ["Venice", "Paris", "Warsaw", "Cracow", "Berlin", "London","Barcelona"],states: ["Clear", "Snow", "Heavy Rain", "Heavy Cloud", "Light Cloud", "Showers", "Thunderstorm"])
    
    @Published private(set) var model: WeatherModel  = WeatherModel(cities: ["0","2459115","2442047","4118","44418","615702","2487956"],states: ["Clear", "Snow", "Heavy Rain", "Heavy Cloud", "Light Cloud", "Showers", "Thunderstorm"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    @Published var currLocation: CLLocation?
    @Published var currLocationName: String
    private let weatherFetcher: WeatherFetcher
    private var cancellables: Set<AnyCancellable> = []
    private let localizationtionFetcher: LocalizationFetcher
    private let locationManager: CLLocationManager
    override init(){
        weatherFetcher = WeatherFetcher()
        localizationtionFetcher = LocalizationFetcher()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        currLocationName = "default"
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        for record in records{
            fetch(forId: record.woeId, record: record) // dla każdego rekordu wykonuję zapytanie do bazy pobierające dane o pogodzie
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        currLocation = locations.last
        let geocoder = CLGeocoder()
        if let location = currLocation{
            geocoder.reverseGeocodeLocation(location){ placemarks, error in self.currLocationName = placemarks![0].locality!
                
            }
        }
    }
    
    func fetch(forId woeId:String, record: WeatherModel.WeatherRecord){ // metoda wykonująca zapytanie do api
        let i = records.firstIndex(of: record) ?? 0
        if i == 0{
            localizationtionFetcher.localization(forId: currLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 49.82, longitude: 19.04))
                .sink(receiveCompletion: {completion in}, receiveValue: {locationValue in self.weatherFetcher.forecast(forId: String(locationValue[0].woeid))
                    .sink(receiveCompletion: {completion in}, receiveValue: {
                            value in self.refresh(woeId: woeId, response: value, record: record, currLocationName: self.currLocationName)}).store(in: &self.cancellables)
                }).store(in: &cancellables)
        }
        weatherFetcher.forecast(forId: woeId).sink(receiveCompletion: {completion in}, receiveValue: {[self]response in self.refresh(woeId: woeId, response: response, record: record, currLocationName: "")}).store(in: &cancellables)
    }
    
    func refresh(record: WeatherModel.WeatherRecord){
        model.refresh(record: record)
    }
    
    func refresh(woeId: String, response: WeatherResponse, record: WeatherModel.WeatherRecord, currLocationName: String){
        model.refresh(woeId: woeId, response: response, record: record, currLocationName: currLocationName)
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
