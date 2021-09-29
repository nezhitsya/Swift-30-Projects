//
//  Protocol+ReusableCell.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
