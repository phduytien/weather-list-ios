//
//  HTTPCode.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

enum HTTPResponseStatusCode: Int {
    case noInternet                     = -1
    case unknown                        = 0
    case ok                             = 200
    case badRequest                     = 400
    case notFound                       = 404
}
