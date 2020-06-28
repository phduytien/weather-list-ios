//
//  WeatherListCache.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

class WeatherListCache {
    
    // MARK: - Singleton
    
    static let shared: WeatherListCache = WeatherListCache()
    
    // MARK: - Private properties
    
    // Default value is 10 minute
    private var cacheSafeTimeInSeconds: TimeInterval = 10 * 60
    // Store weather list item base on queryString
    private var storage: [String: [WeatherItemUIModel]]
    private var timer: Timer?
    
    // MARK: - Initialize
    
    private init() {
        storage = [:]
        updateCacheTimer()
    }
    
    func updateCacheTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: cacheSafeTimeInSeconds,
                                     target: self,
                                     selector: #selector(timerHandler),
                                     userInfo: nil,
                                     repeats: true)
    }
}

// MARK: - Public
extension WeatherListCache {
    func add(_ item: [WeatherItemUIModel], for query: String) {
        guard storage[query] == nil else {
            return
        }
        storage[query] = item
    }
    
    func weatherList(for query: String) -> [WeatherItemUIModel]? {
        let result = storage[query]
        return result
    }
    
    func empty() {
        storage.removeAll()
        storage = [:]
    }
}

// MARK: - Private functions
private extension WeatherListCache {
    @objc func timerHandler() {
        empty()
    }
}
