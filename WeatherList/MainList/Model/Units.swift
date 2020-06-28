//
//  Units.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

enum Units: String {
    case `default`
    case metric
    case imperial
    
    var longTemperatureUnit: String {
        switch self {
        case .metric:
            return "Celsius"
        case .imperial:
            return "Fahrenheit"
        default:
            return "Kelvin"
        }
    }
    
    var shortTemperatureUnit: String {
        switch self {
        case .metric:
            return "°C"
        case .imperial:
            return "°F"
        default:
            return "K"
        }
    }
}
