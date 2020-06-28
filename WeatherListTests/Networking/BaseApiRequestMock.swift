//
//  BaseApiRequestMock.swift
//  WeatherListTests
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

@testable import WeatherList

class BaseApiRequestMock: BaseApiRequest {
    
    var isMockingRequestExecuting: Bool = false
    var isMockingRequestSucceeded: Bool = true
    
    private var weatherListSucceededResponse: WeatherListResponse = TestHelper.model(from: "succeededWeatherListResponse")
    private var weatherListFailedResponse: WeatherListResponse = TestHelper.model(from: "failedWeatherListResponse1")
    
    typealias ReceivedModel = WeatherListResponse
    
    func execute(completion: @escaping ApiRequestCompletionType) {
        if isMockingRequestExecuting {
            if isMockingRequestSucceeded {
                completion(weatherListSucceededResponse, .ok, nil)
            } else {
                completion(weatherListFailedResponse, .notFound, nil)
            }
        } else {
            completion(nil, nil, nil)
        }
    }
    
    func cancelRequest() {
        isMockingRequestExecuting = false
    }
    
    func isExecuting() -> Bool {
        return isMockingRequestExecuting
    }
}
