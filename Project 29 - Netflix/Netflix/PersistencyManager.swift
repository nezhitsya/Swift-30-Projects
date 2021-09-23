//
//  PersistencyManager.swift
//  Netflix
//
//  Created by 이다영 on 2021/09/23.
//

import UIKit

final class PersistencyManager: NSObject {
    var contentsList: Movies!
    var dramaList = [Drama]()
    var scifiList = [SciFi]()
    var horrorList = [Horror]()
    var allMovies = [String: String]()

    override init() {
        super.init()
        
        guard let savedURL = URL(string: "https://raw.githubusercontent.com/nezhitsya/Swift-30-Projects/master/Project%2029%20-%20Netflix/movies.json") else {
            print("api is down")
            return
        }
        let data = try? Data(contentsOf: savedURL)

        if let response = try? JSONDecoder().decode(Movies.self, from: data!) {
            self.contentsList = response
            self.dramaList = self.contentsList.Drama
            self.horrorList = self.contentsList.Horror
            self.scifiList = self.contentsList.SciFi
        }
        
        for i in 0..<max(dramaList.count, horrorList.count, scifiList.count) - 1 {
            if i < dramaList.count {
                allMovies[dramaList[i].title] = dramaList[i].poster
            }
            if i < horrorList.count {
                allMovies[horrorList[i].title] = horrorList[i].poster
            }
            if i < scifiList.count {
                allMovies[scifiList[i].title] = scifiList[i].poster
            }
        }
    }
}
