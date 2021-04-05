//
//  UIImage.swift
//  Album
//
//  Created by 이다영 on 2021/04/05.
//

import UIKit

extension UIImage {
    func thumbnailOfSize(_ size: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: size, height: size))
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return thumbnail!
    }
}
