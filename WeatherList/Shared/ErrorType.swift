//
//  ErrorType.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

enum ErrorType {
    case invalidCity
    
    var errorTitle: String? {
        switch self {
        case .invalidCity:
            return "Invalid City Name"
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .invalidCity:
            return "Search city name must has minimum 3 characters or not be empty. Please try to input again!"
        }
    }
}

