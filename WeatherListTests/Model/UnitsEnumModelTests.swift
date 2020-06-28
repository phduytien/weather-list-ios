//
//  UnitsEnumModelTests.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import XCTest
@testable import WeatherList

class UnitsEnumModelTests: XCTestCase {

    private var units: Units = .default

    override func setUp() {
        units = .default
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDefaultValueOfUnit() {
        XCTAssertNotNil(units)
        XCTAssertTrue(units.shortTemperatureUnit == "K")
        XCTAssertTrue(units.longTemperatureUnit == "Kelvin")
    }
    
    func testMetricValueOfUnit() {
        units = .metric
        XCTAssertNotNil(units)
        XCTAssertTrue(units.shortTemperatureUnit == "°C")
        XCTAssertTrue(units.longTemperatureUnit == "Celsius")
    }
    
    func testImperialValueOfUnit() {
        units = .imperial
        XCTAssertNotNil(units)
        XCTAssertTrue(units.shortTemperatureUnit == "°F")
        XCTAssertTrue(units.longTemperatureUnit == "Fahrenheit")
    }
}
