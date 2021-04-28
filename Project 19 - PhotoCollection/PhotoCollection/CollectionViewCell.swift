//
//  CollectionViewCell.swift
//  PhotoCollection
//
//  Created by 이다영 on 2021/04/28.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var caption: UILabel!
    @IBOutlet private weak var comment: UILabel!
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                caption.text = photo.caption
                comment.text = photo.comment
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        if let attributes = layoutAttributes as? CollectionLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }
}
