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
    static let seeMore = "See More ..."
    static let addFavorites = "Add Favorites ..."
    static let logout = "Log Out"
    
    static func populate(withUser user: User) -> [[String: Any]] {
        return [
            [
                TableKey.Rows: [
                    [TableKey.ImageName: user.nickname, TableKey.Title: user.name, TableKey.SubTitle: user.description]
                ]
            ],
            [
                TableKey.Rows: [
                    [TableKey.ImageName: Specs.imageName.friends, TableKey.Title: "Friends"],
                    [TableKey.ImageName: Specs.imageName.events, TableKey.Title: "Events"],
                    [TableKey.ImageName: Specs.imageName.groups, TableKey.Title: "Groups"],
                    [TableKey.ImageName: Specs.imageName.townHall, TableKey.Title: "Town Hall"],
                    [TableKey.ImageName: Specs.imageName.instantGames, TableKey.Title: "Instant Games"],
                    [TableKey.Title: TableKey.seeMore]
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
                    [TableKey.ImageName: Specs.imageName.settings, TableKey.Title: "Settings"],
                    [TableKey.ImageName: Specs.imageName.privacyShortcuts, TableKey.Title: "Privacy Shortcuts"],
                    [TableKey.ImageName: Specs.imageName.helpSupport, TableKey.Title: "Help and Support"]
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
