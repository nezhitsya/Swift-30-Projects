//
//  APICenter.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/26.
//

import Foundation

// MARK: API KEY
let weatherAPIKey = ""

// MARK: HTTPMethod
// GET, PUT, POST, DELETE
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

// MARK: HTTPHeader
// field, value
struct HTTPHeader {
    let field: String
    let value: String
}
