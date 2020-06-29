//
//  WeatherItemUIModel.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

struct WeatherItemUIModel {
    
    // MARK: - Properties
    
    let date: Date?
    let averageTemperature: Double?
    let pressure: Int?
    let humidity: Int?
    let weatherDescription: String?
    
    // MARK: - Initialize
    
    init(_ response: WeatherItem) {
        // Date
        if let dateInterval = response.date {
            date = Date(timeIntervalSince1970: dateInterval)
        } else {
            date = nil
        }
        // Average Temperature
        if let temperate = response.temperature {
            let max = temperate.max
            let min = temperate.min
            if let max = max, let min = min {
                averageTemperature = (max + min) / 2.0
            } else if let max = max {
                averageTemperature = max
            } else if let min = min {
                averageTemperature = min
            } else {
                averageTemperature = nil
            }
        } else {
            averageTemperature = nil
        }
        // Pressure
        pressure = response.pressure
        // Humidity
        humidity = response.humidity
        // Weather description
        weatherDescription = response.weather?.first?.weatherDescription
    }
    
    // MARK: - Public methods
    
    func weatherItemDescription(unit: Units) -> String? {
        var desc: [String] = []
        if let date = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, d MMM yyyy"
            desc.append("Date: \(formatter.string(from: date))")
        }
        if let averageTemperature = averageTemperature {
            desc.append(String(format: "Average Temperature: %.2f%@", averageTemperature, unit.shortTemperatureUnit))
        }
        if let pressure = pressure {
            desc.append("Pressure: \(pressure)")
        }
        if let humidity = humidity {
            desc.append("Humidity: \(humidity)%")
        }
        if let weatherDescription = weatherDescription, !StringHelper.isEmptyText(weatherDescription) {
            desc.append("Description: \(weatherDescription)")
        }
        return desc.joined(separator: "\n")
    }
}
