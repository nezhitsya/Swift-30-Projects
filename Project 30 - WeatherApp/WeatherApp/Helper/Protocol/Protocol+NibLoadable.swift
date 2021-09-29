//
//  Protocol+NibLoadable.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import UIKit

protocol NibLoadable: class {
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
