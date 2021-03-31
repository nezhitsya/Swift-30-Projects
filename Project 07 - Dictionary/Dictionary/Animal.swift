//
//  Animal.swift
//  Dictionary
//
//  Created by 이다영 on 2021/03/31.
//

import Foundation

enum AnimalType {
    case Amphibia
    case Reptile
    case Mammalia
}

class Animal: NSObject {
    let name: String
    let detailInfo: String
    let type: [AnimalType]
    let animImgUrl: String
    
    init(name: String, detailInfo: String, type: [AnimalType], animImgUrl: String) {
        self.name = name
        self.detailInfo = detailInfo
        self.type = type
        self.animImgUrl = animImgUrl
    }
}
