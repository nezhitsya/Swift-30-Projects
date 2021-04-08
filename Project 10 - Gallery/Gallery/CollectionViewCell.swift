//
//  CollectionViewCell.swift
//  Gallery
//
//  Created by 이다영 on 2021/04/07.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var collection: Collections! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        title.text = collection.title
        collectionImage.image = collection.collectionImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
}
