//
//  ErrorType.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

enum ErrorType {
    case invalidCity
    case fetchingNoInternet
    case fetchingBadRequest
    case fetchingUnknown
    
    var errorTitle: String? {
        switch self {
        case .invalidCity:
            return "Invalid City Name"
        case .fetchingBadRequest, .fetchingUnknown, .fetchingNoInternet:
            return "Fetched Weather List Failed"
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .invalidCity:
            return "Search city name must has minimum 3 characters or not be empty. Please try to input again!"
        case .fetchingNoInternet:
            return "No internet connection. Please connect and try again"
        case .fetchingBadRequest:
            return "Number of days must from 1 to 17. Please input correctly and try again"
        case .fetchingUnknown:
            return "Something went wrong. Please try again"
        }
    }
}

