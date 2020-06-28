//
//  StringHelper.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

struct StringHelper {
    static func isEmptyText(_ text: String?) -> Bool {
        if NSNull().isEqual(text) || nil == text || ("" == text) || (text?.count ?? 0) == 0 {
            return true
        }
        return false
    }
}
