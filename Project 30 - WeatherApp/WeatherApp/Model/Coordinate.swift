//
//  Coordinate.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import Foundation

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

extension Coordinate: Equatable {
    static func == (A: Coordinate, B: Coordinate) -> Bool {
        return A.lat == B.lat && A.lon == B.lon
    }
}
