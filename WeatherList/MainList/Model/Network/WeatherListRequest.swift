//
//  WeatherListRequest.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

struct WeatherListRequest {
    let cityName: String?
    let numberOfDays: String?
    let unit: Units?
    
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
}
