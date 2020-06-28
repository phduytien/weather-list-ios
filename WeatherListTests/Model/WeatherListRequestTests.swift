//
//  WeatherListRequestTests.swift
//  WeatherListTests
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import XCTest
@testable import WeatherList

class WeatherListRequestTests: XCTestCase {

    private var weatherListRequest: WeatherListRequest?
    
    override func setUp() {
        
    }

    override func tearDown() {
        weatherListRequest = nil
        super.tearDown()
    }
    
    func testInitWithFullData() {
        weatherListRequest = WeatherListRequestTests.fullWeatherListRequest
        XCTAssertNotNil(weatherListRequest)
        XCTAssertNotNil(weatherListRequest!.cityName)
        XCTAssertNotNil(weatherListRequest!.numberOfDays)
        XCTAssertNotNil(weatherListRequest!.unit)
       
        XCTAssertTrue(weatherListRequest!.cityName == "Ho CHi Minh")
        XCTAssertTrue(weatherListRequest!.numberOfDays == "7")
        XCTAssertTrue(weatherListRequest!.unit == .default)
    }
    
    func testInitWithFullDataQuery() {
        weatherListRequest = WeatherListRequestTests.fullWeatherListRequest
        XCTAssertNotNil(weatherListRequest)
        XCTAssertNotNil(weatherListRequest!.cityName)
        XCTAssertNotNil(weatherListRequest!.numberOfDays)
        XCTAssertNotNil(weatherListRequest!.unit)
        
        XCTAssertTrue(weatherListRequest!.query == "appId=60c6fbeb4b93ac653c492ba806fc346d&q=Ho CHi Minh&cnt=7")
        XCTAssertTrue(weatherListRequest!.storeQuery == "q=Ho CHi Minh")
    }
    
    func testInitWithMissingData() {
        weatherListRequest = WeatherListRequestTests.missingWeatherListRequest
        XCTAssertNotNil(weatherListRequest)
        XCTAssertNotNil(weatherListRequest!.cityName)
        XCTAssertNil(weatherListRequest!.numberOfDays)
        XCTAssertNotNil(weatherListRequest!.unit)
       
        XCTAssertTrue(weatherListRequest!.cityName == "Ha Noi")
        XCTAssertTrue(weatherListRequest!.unit == .imperial)
    }
    
    func testInitWithMissingDataQuery() {
        weatherListRequest = WeatherListRequestTests.missingWeatherListRequest
        XCTAssertNotNil(weatherListRequest)
        XCTAssertNotNil(weatherListRequest!.cityName)
        XCTAssertNil(weatherListRequest!.numberOfDays)
        XCTAssertNotNil(weatherListRequest!.unit)
        
        XCTAssertTrue(weatherListRequest!.query == "appId=60c6fbeb4b93ac653c492ba806fc346d&q=Ha Noi&units=imperial")
        XCTAssertTrue(weatherListRequest!.storeQuery == "q=Ha Noi&units=imperial")
    }
}

extension WeatherListRequestTests {
    static let fullWeatherListRequest: WeatherListRequest = WeatherListRequest(cityName: "Ho CHi Minh", numberOfDays: "7", unit: .default)
    static let missingWeatherListRequest: WeatherListRequest = WeatherListRequest(cityName: "Ha Noi", numberOfDays: nil, unit: .imperial)
}
