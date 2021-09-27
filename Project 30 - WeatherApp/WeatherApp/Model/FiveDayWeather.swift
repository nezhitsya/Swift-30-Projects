//
//  FiveDayWeather.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/27.
//

import Foundation

struct FiveDayWeather: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List]
    let city: City
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let timezone: Int
    var population: Int?
}

struct List: Codable {
    let dt: Int
    let main: FiveMain
    let weather: [FiveWeather]
    let clouds: Clouds
    let wind: Wind
    let sys: FiveSys
    let dtTxt: String
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

struct FiveMain: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let seaLevel: Double
    let grndLevel: Double
    let humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Rain: Codable {
    let threeH: Double?
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

struct FiveSys: Codable {
    let pod: String
}

struct FiveWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
