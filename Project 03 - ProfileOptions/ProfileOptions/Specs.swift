//
//  Specs.swift
//  ProfileOptions
//
//  Created by 이다영 on 2021/03/19.
//

import UIKit

public struct Specs {
    public struct Color {
        public let tint = UIColor(red: 0.77, green: 0.82, blue: 0.86, alpha: 1.00)
        public let red = UIColor.red
        public let gray = UIColor.lightGray
        public let blue = UIColor.blue
    }
    
    public struct ImageName {
        public let friends = "friends"
        public let events = "events"
        public let groups = "groups"
        public let townHall = "town_hall"
        public let instantGames = "games"
        public let settings = "settings"
        public let privacyShortcuts = "privacy_shortcuts"
        public let helpSupport = "help_and_support"
    }
    
    public static var color: Color {
        return Color()
    }
    
    public static var imageName: ImageName {
        return ImageName()
    }
}
