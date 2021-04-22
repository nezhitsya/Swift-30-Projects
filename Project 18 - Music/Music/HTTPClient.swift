//
//  HTTPClient.swift
//  Music
//
//  Created by 이다영 on 2021/04/23.
//

import UIKit

class HTTPClient {
    
    func getRequest(_ url: String) -> (AnyObject) {
        return Data() as (AnyObject)
    }
    
    func postRequest(_ url: String, body: String) -> (AnyObject) {
        return Data() as (AnyObject)
    }
    
    func downloadImage(_ url: String) -> (UIImage) {
        let aUrl = URL(string: url)
        
        guard let data = try? Data(contentsOf: aUrl!) else {
            return UIImage()
        }
        
        let image = UIImage(data: data)
        
        return image!
    }
}
