//
//  UIView+Subviews.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
