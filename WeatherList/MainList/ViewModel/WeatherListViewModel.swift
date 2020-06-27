//
//  WeatherListViewModel.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import UIKit

class WeatherListViewModel: NSObject {
    
    let arrTemperatureUnits: [Units] = [.default, .metric, .imperial]
    var arrNumOfDays: [String] {
        var output: [String] = [String]()
        for i in 1...17 {
            if i == 1 {
                output.append("\(i) day")
            } else {
                output.append("\(i) days")
            }
        }
        return output
    }
    
    weak var delegate: WeatherListViewDelegate?
    
}

extension WeatherListViewModel: UISearchBarDelegate {
    
}
