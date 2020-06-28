//
//  WeatherItem.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

struct WeatherItem: Codable {
    
    let date: Double?
    let pressure: Int?
    let humidity: Int?
    let temperature: Temperature?
    let weather: [Weather]?
    
    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case pressure
        case humidity
        case weather
    }
}
