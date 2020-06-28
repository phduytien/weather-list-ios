//
//  Temperature.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

struct Temperature: Codable {
    let max: Double?
    let min: Double?
    
    private enum CodingKeys: String, CodingKey {
        case max
        case min
    }
}
