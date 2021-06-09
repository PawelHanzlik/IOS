//
//  WeatherFetcher.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 08/06/2021.
//

import Foundation
import Combine

class WeatherFetcher{
    
    // metoda wykonująca faktyczne zapytanie do API
    func forecast(forId woeId: String) -> AnyPublisher<WeatherResponse, Error>{
        let url: URL = URL(string: "https://www.metaweather.com/api/location/\(woeId)/")!
        return URLSession.shared.dataTaskPublisher(for: url).map{$0.data}.decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
