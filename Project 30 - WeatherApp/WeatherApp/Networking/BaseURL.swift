//
//  BaseURL.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/26.
//

import Foundation

//MARK: BaseURL
struct BaseURL {
    static let weatherURL = "https://api.openweathermap.org"
    static let webURL = "https://weather.com/"
}

//MARK: BasePath
struct BasePath {
    static let list = "/data/2.5/weather"
    static let current = "/data/2.5/forecast"
}
