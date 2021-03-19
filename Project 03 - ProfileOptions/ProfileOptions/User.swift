//
//  User.swift
//  ProfileOptions
//
//  Created by 이다영 on 2021/03/18.
//

import UIKit

class User {
    var name: String
    var nickname: String
    var description: String
    
    init(name: String, nickname: String = "랭리자베스", description: String) {
        self.name = name
        self.nickname = nickname
        self.description = description
    }
}
