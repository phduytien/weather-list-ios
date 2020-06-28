//
//  Weather.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let weatherDescription: String?

    private enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
    }
}
