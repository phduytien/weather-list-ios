//
//  WeatherItemUIModelTests.swift
//  WeatherListTests
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import XCTest
@testable import WeatherList

class WeatherItemUIModelTests: XCTestCase {

    private var weatherItemUIModel: WeatherItemUIModel?
    private var fullWeatherItem: WeatherItem?
    private var missingWeatherItem: WeatherItem?
    
    override func setUp() {
        fullWeatherItem = WeatherItemUIModelTests.model(from: "fullWeatherItem")
        missingWeatherItem = WeatherItemUIModelTests.model(from: "missingWeatherItem")
    }

    override func tearDown() {
        fullWeatherItem = nil
        weatherItemUIModel = nil
        missingWeatherItem = nil
        super.tearDown()
    }
    
    func testInitFullDataModelFromResponse() {
        XCTAssertNotNil(fullWeatherItem)
        weatherItemUIModel = WeatherItemUIModel(fullWeatherItem!)
        XCTAssertNotNil(weatherItemUIModel)
        XCTAssertNotNil(weatherItemUIModel!.date)
        XCTAssertNotNil(weatherItemUIModel!.averageTemperature)
        XCTAssertNotNil(weatherItemUIModel!.pressure)
        XCTAssertNotNil(weatherItemUIModel!.humidity)
        XCTAssertNotNil(weatherItemUIModel!.weatherDescription)
        
        XCTAssertTrue(weatherItemUIModel!.date == Date(timeIntervalSince1970: 1593316800))
        XCTAssertTrue(weatherItemUIModel!.averageTemperature == 26.995)
        XCTAssertTrue(weatherItemUIModel!.pressure == 1005)
        XCTAssertTrue(weatherItemUIModel!.humidity == 88)
        XCTAssertTrue(weatherItemUIModel!.weatherDescription == "moderate rain")
    }
    
    func testInitMissingDataModelFromResponse() {
        XCTAssertNotNil(missingWeatherItem)
        weatherItemUIModel = WeatherItemUIModel(missingWeatherItem!)
        XCTAssertNotNil(weatherItemUIModel)
        XCTAssertNotNil(weatherItemUIModel!.date)
        XCTAssertNotNil(weatherItemUIModel!.averageTemperature)
        XCTAssertNotNil(weatherItemUIModel!.pressure)
        XCTAssertNotNil(weatherItemUIModel!.humidity)
        XCTAssertNil(weatherItemUIModel!.weatherDescription)
        
        XCTAssertTrue(weatherItemUIModel!.date == Date(timeIntervalSince1970: 1593316800))
        XCTAssertTrue(weatherItemUIModel!.averageTemperature == 26.8)
        XCTAssertTrue(weatherItemUIModel!.pressure == 1005)
        XCTAssertTrue(weatherItemUIModel!.humidity == 88)
    }
    
    func testInitFullDataModelFromResponseDesscription() {
        XCTAssertNotNil(fullWeatherItem)
        weatherItemUIModel = WeatherItemUIModel(fullWeatherItem!)
        XCTAssertNotNil(weatherItemUIModel)
        XCTAssertTrue(weatherItemUIModel!.weatherItemDescription(unit: .default) == "Date: Sun, 28 Jun 2020\nAverage Temperature: 27.00K\nPressure: 1005\nHumidity: 88%\nDescription: moderate rain")
    }
    
    func testInitMissingDataModelFromResponseDesscription() {
        XCTAssertNotNil(fullWeatherItem)
        weatherItemUIModel = WeatherItemUIModel(missingWeatherItem!)
        XCTAssertNotNil(weatherItemUIModel)
        XCTAssertTrue(weatherItemUIModel!.weatherItemDescription(unit: .default) == "Date: Sun, 28 Jun 2020\nAverage Temperature: 26.80K\nPressure: 1005\nHumidity: 88%")
    }
}

extension WeatherItemUIModelTests {
    static func model(from jsonFile: String) -> WeatherItem {
        let helper = TestHelper.shared
        guard let data = helper.dataFromJsonResource(fileName: jsonFile) else {
            fatalError("Json file not found!")
        }
        do {
            let decoder = helper.jsonDecoder
            let model = try decoder.decode(WeatherItem.self, from: data)
            return model
        } catch {
            fatalError("Could not decode data to WeatherItem")
        }
    }
}
