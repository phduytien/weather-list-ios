//
//  WeatherListResponseTests.swift
//  WeatherListTests
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import XCTest
@testable import WeatherList

class WeatherListResponseTests: XCTestCase {

    private var weatherListResponse: WeatherListResponse?
    
    override func setUp() {
        weatherListResponse = TestHelper.model(from: "succeededWeatherListResponse")
    }

    override func tearDown() {
        weatherListResponse = nil
        super.tearDown()
    }
    
    func testInitSucceedDataModelFromResponse() {
        XCTAssertNotNil(weatherListResponse)
        XCTAssertNotNil(weatherListResponse!.statusCode)
        XCTAssertNotNil(weatherListResponse!.message)
        XCTAssertNotNil(weatherListResponse!.items)
        
        XCTAssertTrue(weatherListResponse!.statusCode == 200)
        XCTAssertTrue(weatherListResponse!.message == "4.82251")
        XCTAssertTrue(weatherListResponse!.items?.count == 7)
    }
    
    func testInitFailedDataModelFromResponse1() {
        weatherListResponse = TestHelper.model(from: "failedWeatherListResponse1")
        XCTAssertNotNil(weatherListResponse)
        XCTAssertNotNil(weatherListResponse!.statusCode)
        XCTAssertNotNil(weatherListResponse!.message)
        XCTAssertNil(weatherListResponse!.items)
        
        XCTAssertTrue(weatherListResponse!.statusCode == 404)
        XCTAssertTrue(weatherListResponse!.message == "city not found")
    }
    
    func testInitFailedDataModelFromResponse2() {
        weatherListResponse = TestHelper.model(from: "failedWeatherListResponse2")
        XCTAssertNotNil(weatherListResponse)
        XCTAssertNotNil(weatherListResponse!.statusCode)
        XCTAssertNotNil(weatherListResponse!.message)
        XCTAssertNil(weatherListResponse!.items)
        
        XCTAssertTrue(weatherListResponse!.statusCode == 400)
        XCTAssertTrue(weatherListResponse!.message == "cnt from 1 to 17")
    }
}
