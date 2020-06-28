//
//  WeatherListViewModel.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import UIKit

class WeatherListViewModel {
    
    weak var delegate: WeatherListViewDelegate?
    
    var apiRequest: ApiRequest?
    var weatherListCache = WeatherListCache.shared
    
    // MARK: - Initilize
    
    init(delegate: WeatherListViewDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Network Operation
    
    func fetchWeatherListWithRequest(_ request: WeatherListRequest) {
        // Check if cache has current query or not
        if let weatherList = weatherListCache.weatherList(for: request.storeQuery) {
            print("Existed in cache. Load: \(request.query)")
            delegate?.didFetchWeatherListSucceed(weatherList)
        } else {
            print("Fetch new")
            apiRequest = ApiRequest(baseURl: API.baseUrl, path: API.apiPath, query: request.query)
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let self = self else { return }
                self.apiRequest?.execute(completion: { (response, statusCode, error) in
                    self.apiRequest = nil
                    if let weatherList = response?.items {
                        let weatherListUIModel = weatherList.compactMap { WeatherItemUIModel($0) }
                        // Caching if query isn't existed
                        self.weatherListCache.add(weatherListUIModel, for: request.storeQuery)
                        DispatchQueue.main.async {
                            self.delegate?.didFetchWeatherListSucceed(weatherListUIModel)
                        }
                    } else  {
                        DispatchQueue.main.async {
                            self.delegate?.didFetchWeatherListFailed(statusCode, errorMessage: error?.localizedDescription)
                        }
                    }
                })
            }
        }
    }
    
    func cancelRequest() {
        apiRequest?.cancelRequest()
        apiRequest = nil
    }
    
    func isRequesting() -> Bool {
        apiRequest?.isExecuting() ?? false
    }
}
