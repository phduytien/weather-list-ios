//
//  TestHelper.swift
//  WeatherListTests
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation
@testable import WeatherList

class TestHelper {
    
    static let shared = TestHelper()
    
    var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        return encoder
    }
    
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        return decoder
    }
    
    func dataFromJsonResource(fileName: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: fileName, ofType: "json")
        return try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
    }
}

extension TestHelper {
    static func model(from jsonFile: String) -> WeatherListResponse {
        let helper = TestHelper.shared
        guard let data = helper.dataFromJsonResource(fileName: jsonFile) else {
            fatalError("Json file not found!")
        }
        do {
            let decoder = helper.jsonDecoder
            let model = try decoder.decode(WeatherListResponse.self, from: data)
            return model
        } catch {
            fatalError("Could not decode data to WeatherItem")
        }
    }
}
