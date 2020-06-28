//
//  WeatherResponse.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

struct WeatherListResponse: Codable {
    
    let statusCode: Int?
    let message: String?
    let items: [WeatherItem]?
    
    private enum CodingKeys: String, CodingKey {
        case statusCode = "cod"
        case message
        case items = "list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try Int(container.decode(String.self, forKey: .statusCode)) ?? 0
        do {
            items = try container.decode([WeatherItem].self, forKey: .items)
        } catch DecodingError.keyNotFound {
            items = nil
        }
        do {
            message = try String(container.decode(Double.self, forKey: .message))
        } catch DecodingError.typeMismatch {
            message = try container.decode(String.self, forKey: .message)
        }
    }
}
