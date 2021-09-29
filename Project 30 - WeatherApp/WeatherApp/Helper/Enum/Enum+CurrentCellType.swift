//
//  Enum+CurrentCellType.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import UIKit

enum CurrentCellType: Int {
    case TimesCell = 0
    case DetailCell
    case DaysCell
}

extension CurrentCellType {
    var cellType: UITableViewCell.Type {
        switch self {
        case .DaysCell:
            return DaysTableViewCell.self
        case .DetailCell:
            return DetailTableViewCell.self
        case .TimesCell:
            return CurrentWeatherTimesTableViewCell.self
        }
    }
}
