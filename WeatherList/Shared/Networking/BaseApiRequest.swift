//
//  BaseApiRequest.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

protocol BaseApiRequest {
    typealias ApiRequestCompletionType = (ReceivedModel?, HTTPResponseStatusCode?, Error?) -> Void
    associatedtype ReceivedModel: Decodable
    
    func execute(completion: @escaping ApiRequestCompletionType)
    func cancelRequest()
    func isExecuting() -> Bool
}
