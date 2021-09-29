//
//  Enum+Week.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import Foundation

enum Week: Int {
    case Sun = 1
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sta
}

extension Week {
    var StringValue: String {
        switch self {
        case .Sun:
            return "Sunday"
        case .Mon:
            return "Monday"
        case .Tue:
            return "Tuesday"
        case .Wed:
            return "Wednesday"
        case .Thu:
            return "Thursday"
        case .Fri:
            return "Friday"
        case .Sta:
            return "Saturday"
        }
    }
}
