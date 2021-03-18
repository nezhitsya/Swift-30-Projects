//
//  TableKey.swift
//  ProfileOptions
//
//  Created by 이다영 on 2021/03/18.
//

import Foundation

public struct TableKey {
    static let Section = "section"
    static let Rows = "rows"
    static let ImageName = "imageName"
    static let Title = "title"
    static let SubTitle = "subTitle"
    static let seeMode = "See More ..."
    static let addFavorites = "Add Favorites ..."
    static let logout = "Log Out"
    
    static func populate(withUser user: User) -> [[String: Any]] {
        return [
            [
                TableKey.Rows: [
                    [TableKey.ImageName: user.nickname, TableKey.Title: user.name, TableKey.SubTitle: "Profile"]
                ]
            ],
            [
                TableKey.Rows: [
                    
                ]
            ],
            [
                TableKey.Section: "FAVORITES",
                TableKey.Rows: [
                    [TableKey.Title: TableKey.addFavorites]
                ]
            ],
            [
                TableKey.Rows: [
                    
                ]
            ],
            [
                TableKey.Rows: [
                    [TableKey.Title: TableKey.logout]
                ]
            ]
        ]
    }
}
