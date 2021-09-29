//
//  Enum+FahrenheitOrCelsius.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import Foundation

enum FahrenheitOrCelsius: String {
    case Fahrenheit
    case Celsius
}

extension FahrenheitOrCelsius {
    var stringValue: String {
        return "\(self)"
    }
    
    var emoji: String {
        switch self {
        case .Celsius:
            return "℃"
        case .Fahrenheit:
            return "℉"
        }
    }
}
