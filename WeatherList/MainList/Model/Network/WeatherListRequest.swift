//
//  WeatherListRequest.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

struct WeatherListRequest {
    
    // MARK: - Properties
    
    let cityName: String?
    let numberOfDays: String?
    let unit: Units?
    
    // MARK: - Public Properties
    
    // For making query request API
    var query: String {
        var queries: [String] = []
        queries.append("appId=\(API.appId)")
        if let cityName = cityName, !StringHelper.isEmptyText(cityName) {
            queries.append("q=\(cityName)")
        }
        if let numberOfDays = numberOfDays, !StringHelper.isEmptyText(numberOfDays) {
            queries.append("cnt=\(numberOfDays)")
        }
        if let unit = unit, unit != .default {
            queries.append("units=\(unit.rawValue)")
        }
        return queries.joined(separator: "&")
    }
    
    // For making query store caching
    var storeQuery: String {
        var queries: [String] = []
        if let cityName = cityName, !StringHelper.isEmptyText(cityName) {
            queries.append("q=\(cityName)")
        }
        // Empty numberOfDays and 7 days has the same cache
        if let numberOfDays = numberOfDays, !StringHelper.isEmptyText(numberOfDays), numberOfDays != "7" {
            queries.append("cnt=\(numberOfDays)")
        }
        if let unit = unit, unit != .default {
            queries.append("units=\(unit.rawValue)")
        }
        return queries.joined(separator: "&")
    }
}
