//
//  Extension+Double.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import Foundation

extension Double {
    
    func makeCelsius() -> String {
        let argue = self - 273.15
        return String(format: "%.0f", arguments: [argue])
    }
    
    func makeFahrenheit() -> String {
        let argue = (self * 9/5) - 459.67
        return String(format: "%.0f", arguments: [argue])
    }
    
    func makeRound() -> Double {
        return (self * 100).rounded() / 100
    }
}
