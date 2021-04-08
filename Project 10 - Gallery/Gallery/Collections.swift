//
//  Collections.swift
//  Gallery
//
//  Created by 이다영 on 2021/04/07.
//

import UIKit

class Collections {
    var id = ""
    var title = ""
    var description = ""
    var numberOfMemebers = 0
    var numberOfPosts = 0
    var collectionImage: UIImage!
    
    init(id: String, title: String, description: String, collectionImage: UIImage!) {
        self.id = id
        self.title = title
        self.description = description
        self.collectionImage = collectionImage
        numberOfMemebers = 1
        numberOfPosts = 1
    }
    
    static func createCollections() -> [Collections] {
        return [
            Collections(id: "c1", title: "Russia", description: "Known as the ‘City of the Czars’, St Petersburg offers a fascinating glimpse into Russia’s historical relics. It's also one of the most ornate and prettiest cities that's on the fringes of Western Russian.", collectionImage: UIImage(named: "c1")!),
            Collections(id: "c2", title: "Italy", description: "Italy is such a beautiful country to explore, from its gorgeous lakes in the north historic towns and cities and spots like Cinque Terre. Honestly, you'll be spoilt for choice when exploring all the beautiful places.", collectionImage: UIImage(named: "c2")!),
            Collections(id: "c3", title: "Spain", description: "What comes to mind when you think of Seville, Spain? My first thought is how beautiful the city is, with large green spaces, tropical parks and gorgeous architecture. This is why I want to share my Seville photography with you.", collectionImage: UIImage(named: "c3")!),
            Collections(id: "c4", title: "Spain", description: "Barcelona is possibly one of the most iconic and colourful European cities to visit. From the stunning Gaudi Buildings to the yummy restaurants and tapas spots; there's so many best things to see in Barcelona.", collectionImage: UIImage(named: "c4")!),
            Collections(id: "c5", title: "France", description: "Want to know what the top things to do in Paris are? Check out my Blogger's Travel Guide to Paris. Sharing the best things to do and see while in the city.", collectionImage: UIImage(named: "c5")!),
            Collections(id: "c6", title: "England", description: "Take a UK road trip through England and Scotland and experience the beautiful English countryside and historic UK travel destinations.", collectionImage: UIImage(named: "c6")!)
        ]
    }
}
