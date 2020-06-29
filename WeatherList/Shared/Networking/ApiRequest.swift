//
//  ApiRequest.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

class ApiRequest: BaseApiRequest {

    typealias ReceivedModel = WeatherListResponse
    
    // MARK: - Private properties
    
    private var baseURl: String
    private var path: String?
    private var query: String?
    
    private var task: URLSessionDataTask?
    private var isRequesting: Bool = false
    private var url: URL? {
        let baseUrl = URL(string: baseURl)
        var urlComponents = URLComponents()
        urlComponents.scheme = baseUrl?.scheme
        urlComponents.port = baseUrl?.port
        urlComponents.host = baseUrl?.host
        urlComponents.fragment = baseUrl?.fragment
        urlComponents.path = "\(baseUrl?.path ?? "")\(path ?? "")"
        urlComponents.query = query
        
        return urlComponents.url
    }
    
    // MARK: - Initialize
    
    init(baseURl: String, path: String? = nil, query: String? = nil) {
        self.baseURl = baseURl
        self.path = path
        self.query = query
    }
    
    // MARK: - Execute request
    
    func execute(completion: @escaping ApiRequestCompletionType) {
        guard let url = url else { return }
        // Check if internet connected or not
        guard NetworkManager.isConnectedToNetwork() else {
            completion(nil, .noInternet, nil)
            return
        }
        print(url.absoluteString)
        // Cancel existing request if needed
        cancelRequest()
        // Is requesting
        isRequesting = true
        // Start requesting
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            self.task = nil
            guard let dataResponse = data, error == nil else {
                // No response data error
                completion(nil, .unknown, error)
                print("No response data: \(String(describing: error))")
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherListResponse = try decoder.decode(WeatherListResponse.self, from: dataResponse)
                if weatherListResponse.statusCode == HTTPResponseStatusCode.ok.rawValue {
                    completion(weatherListResponse, nil, nil)
                } else {
                    let statusCode: HTTPResponseStatusCode = HTTPResponseStatusCode(rawValue: weatherListResponse.statusCode ?? HTTPResponseStatusCode.unknown.rawValue) ?? .unknown
                    let err = NSError(domain: weatherListResponse.message ?? "", code: statusCode.rawValue, userInfo: nil)
                    completion(nil, statusCode, err)
                }
                print("Parsing JSON succeeded: \(dataResponse)")
            } catch let parsingError {
                print("Parsing JSON failed: \(parsingError)")
                completion(nil, .unknown, parsingError)
            }
        }
        task?.resume()
    }
    
    func cancelRequest() {
        if let task = task {
            task.cancel()
            self.task = nil
            isRequesting = false
        }
    }
    
    func isExecuting() -> Bool {
        return isRequesting
    }
}
