//
//  WeatherListCacheTests.swift
//  WeatherListTests
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import XCTest
@testable import WeatherList

class WeatherListCacheTests: XCTestCase {
    
    private var weatherListCache: WeatherListCache?
    private var weatherListResponse: WeatherListResponse?
    
    override func setUp() {
        weatherListCache = WeatherListCacheMock.shared
        weatherListResponse = TestHelper.model(from: "succeededWeatherListResponse")
    }
    
    override func tearDown() {
        weatherListCache?.empty()
        weatherListCache = nil
        weatherListResponse = nil
        super.tearDown()
    }
    
    func testCacheAddNewItem() {
        XCTAssertNotNil(weatherListResponse)
        XCTAssertNotNil(weatherListCache)
        XCTAssertNotNil(weatherListResponse!.items)
        let weatherListUIModel = weatherListResponse!.items!.compactMap { WeatherItemUIModel($0) }
        XCTAssertNotNil(weatherListUIModel)
        weatherListCache!.add(weatherListUIModel, for: "q=saigon&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric")
        let weatherList = weatherListCache!.weatherList(for: "q=saigon&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric")
        XCTAssertNotNil(weatherList)
        XCTAssertTrue(weatherList!.count > 0)
    }
    
    func testCacheResetAllItem() {
        XCTAssertNotNil(weatherListResponse)
        XCTAssertNotNil(weatherListCache)
        XCTAssertNotNil(weatherListResponse!.items)
        let weatherListUIModel = weatherListResponse!.items!.compactMap { WeatherItemUIModel($0) }
        XCTAssertNotNil(weatherListUIModel)
        weatherListCache!.add(weatherListUIModel, for: "q=saigon&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric")
        weatherListCache!.empty()
        let weatherList = weatherListCache!.weatherList(for: "q=saigon&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric")
        XCTAssertNil(weatherList)
    }
}
