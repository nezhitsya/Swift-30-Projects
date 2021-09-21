//
//  Movies.swift
//  Netflix
//
//  Created by 이다영 on 2021/09/20.
//

import Foundation

struct Movies: Codable {
    let Drama: [Drama]
    let Horror: [Horror]
    let SciFi: [SciFi]
}

struct Drama: Codable {
    var title: String
    var casting: String
    var genre: String
    var poster: String
    var explain: String
    var trailer: String
}

struct Horror: Codable {
    var title: String
    var casting: String
    var genre: String
    var poster: String
    var explain: String
    var trailer: String
}

struct SciFi: Codable {
    var title: String
    var casting: String
    var genre: String
    var poster: String
    var explain: String
    var trailer: String
}
