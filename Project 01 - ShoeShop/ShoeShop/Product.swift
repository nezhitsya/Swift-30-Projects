//
//  Product.swift
//  ShoeShop
//
//  Created by 이다영 on 2021/03/13.
//

import Foundation

class Product {
    var name: String?
    var image: String?
    var fullscreenImage: String?
    
    init(name: String, image: String, fullscreenImage: String) {
        self.name = name
        self.image = image
        self.fullscreenImage = fullscreenImage
    }
}
