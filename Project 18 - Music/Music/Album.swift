//
//  Album.swift
//  Music
//
//  Created by 이다영 on 2021/04/22.
//

import Foundation

struct Album: Codable {
    var title: String
    var artist: String
    var genre: String
    var coverUrl: String
    var year: String
}

extension Album: CustomStringConvertible {
    var description: String {
        return "title: \(title)" + " artist: \(artist)" + " genre: \(genre)" + " coverUrl: \(coverUrl)" + " year: \(year)"
    }
}

typealias AlbumData = (title: String, value: String)

extension Album {
    var tableRepresentation: [AlbumData] {
        return [
            ("Artist", artist),
            ("Album", title),
            ("Genre", genre),
            ("Year", year)
        ]
    }
}
