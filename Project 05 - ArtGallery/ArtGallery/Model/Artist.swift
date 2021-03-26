//
//  Artist.swift
//  ArtGallery
//
//  Created by 이다영 on 2021/03/26.
//

import UIKit

struct Artist {
    let name: String
    let bio: String
    let image: UIImage
    var works: [Work]
    
    init(name: String, bio: String, image: UIImage, works: [Work]) {
        self.name = name
        self.bio = bio
        self.image = image
        self.works = works
    }
}
