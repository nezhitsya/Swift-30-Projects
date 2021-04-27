//
//  UIImage+Decompression.swift
//  PhotoCollection
//
//  Created by 이다영 on 2021/04/27.
//

import UIKit

extension UIImage {
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(at: CGPoint.zero)
        
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return decompressedImage!
    }
}
