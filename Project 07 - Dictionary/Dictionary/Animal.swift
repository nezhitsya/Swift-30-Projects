//
//  Animal.swift
//  Dictionary
//
//  Created by 이다영 on 2021/03/31.
//

import Foundation

enum AnimalType {
    case Amphibia // 양서류
    case Reptilia // 파충류
    case Mammalia // 포유류
    case Birds // 조류
    case Pisces // 어류
}

class Animal: NSObject {
    let name: String
    let detailInfo: String
    let type: [AnimalType]
    let stringType: String
    let animImgUrl: String
    
    init(name: String, detailInfo: String, type: [AnimalType], stringType: String, animImgUrl: String) {
        self.name = name
        self.detailInfo = detailInfo
        self.type = type
        self.stringType = stringType
        self.animImgUrl = animImgUrl
    }
}
