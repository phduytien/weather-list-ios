//
//  BaseApiRequestTests.swift
//  WeatherListTests
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import XCTest
@testable import WeatherList

class BaseApiRequestTests: XCTestCase {
    
    private var apiRequest: BaseApiRequestMock?
    
    override func setUp() {
        apiRequest = BaseApiRequestMock()
    }
    
    override func tearDown() {
        apiRequest = nil
        super.tearDown()
    }
    
    func testExecuteRequestSucceeded() {
        XCTAssertNotNil(apiRequest)
        apiRequest!.isMockingRequestSucceeded = true
        apiRequest!.isMockingRequestExecuting = true
        var weatherListResponse: WeatherListResponse?
        var statusCode: HTTPResponseStatusCode?
        var error: Error?
        let exp = expectation(description: "Fetching all weather list did succeed from API")
        apiRequest!.execute { (reponse, code, err) in
            weatherListResponse = reponse
            statusCode = code
            error = err
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.2, handler: nil)
        XCTAssertNotNil(weatherListResponse)
        XCTAssertNotNil(statusCode)
        XCTAssertNil(error)
        
        XCTAssertNotNil(weatherListResponse!.items)
        XCTAssertNotNil(weatherListResponse!.items!.count == 7)
        XCTAssertNotNil(statusCode == .ok)
    }
    
    func testExecuteRequestFailed() {
        XCTAssertNotNil(apiRequest)
        apiRequest!.isMockingRequestSucceeded = false
        apiRequest!.isMockingRequestExecuting = true
        var weatherListResponse: WeatherListResponse?
        var statusCode: HTTPResponseStatusCode?
        var error: Error?
        let exp = expectation(description: "Fetching all weather list did failed from API")
        apiRequest!.execute { (reponse, code, err) in
            weatherListResponse = reponse
            statusCode = code
            error = err
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.2, handler: nil)
        XCTAssertNotNil(weatherListResponse)
        XCTAssertNotNil(statusCode)
        XCTAssertNil(error)
        
        XCTAssertNil(weatherListResponse!.items)
        XCTAssertNotNil(statusCode == .notFound)
    }
    
    func testCancelRequest() {
        XCTAssertNotNil(apiRequest)
        let exp = expectation(description: "Fetching all weather list did failed from API")
        apiRequest?.isMockingRequestExecuting = true
        apiRequest!.execute { (_, _, _) in
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.5, handler: nil)
        apiRequest!.cancelRequest()
        XCTAssertFalse(apiRequest!.isMockingRequestExecuting)
    }
}
