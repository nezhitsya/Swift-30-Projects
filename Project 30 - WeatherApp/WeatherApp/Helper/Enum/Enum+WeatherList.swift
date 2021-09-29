//
//  Enum+WeatherList.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import Foundation

enum WeatherListCellType: Int {
    case City = 0
    case Setting
}

extension WeatherListCellType: CaseIterable {}
