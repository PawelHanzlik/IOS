//
//  LocalizationFetcher.swift
//  PH_WeatherApp
//
//  Created by AppleLab on 08/06/2021.
//

import Foundation
import Combine
import CoreLocation

class LocalizationFetcher{
    
    func localization(forId coords: CLLocationCoordinate2D) -> AnyPublisher<LocalizationResponse, Error>{
        let url: URL = URL(string: "https://www.metaweather.com/api/location/search/?lattlong=\(coords.latitude),\(coords.longitude)")!
        return URLSession.shared.dataTaskPublisher(for: url).map{$0.data}.decode(type: LocalizationResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
