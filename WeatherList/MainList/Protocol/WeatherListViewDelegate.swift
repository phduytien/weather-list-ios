//
//  WeatherListViewDelegate.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

protocol WeatherListViewDelegate: AnyObject {
    func didFetchWeatherListSucceed(_ list: [WeatherItemUIModel])
    func didFetchWeatherListFailed(_ statusCode: HTTPResponseStatusCode?, errorMessage: String?)
}
