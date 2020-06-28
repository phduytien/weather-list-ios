//
//  Array.swift
//  WeatherList
//
//  Created by TienPham on 6/28/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import Foundation

extension Array {
    func safeElement(at index: Int) -> Element? {
        guard !isEmpty else {
            return nil
        }
        return index < 0 || index > count - 1 ? nil : self[index]
    }
}
