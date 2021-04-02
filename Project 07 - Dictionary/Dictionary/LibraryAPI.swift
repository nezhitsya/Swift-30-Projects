//
//  LibraryAPI.swift
//  Dictionary
//
//  Created by 이다영 on 2021/04/02.
//

import UIKit

class LibraryAPI: NSObject {

    static let sharedInstance = LibraryAPI()
    let persistencyManager = PersistencyManager()
    
    fileprivate override init() {
      super.init()
      
      NotificationCenter.default.addObserver(self, selector:#selector(LibraryAPI.downloadImage(_:)), name: NSNotification.Name(rawValue: downloadImageNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getAnimals() -> [Animal] {
        return animals
    }
    
    func downloadImg(_ url: String) -> (UIImage) {
        let aUrl = URL(string: url)
        let data = try? Data(contentsOf: aUrl!)
        let image = UIImage(data: data!)
        return image!
    }
    
    @objc func downloadImage(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! [String: AnyObject]
        let animalImageView = userInfo["animalImage"] as! UIImageView?
        let animalImageUrl = userInfo["animalImageUrl"] as! String
        
        if let imageViewUnWrapped = animalImageView {
            imageViewUnWrapped.image = persistencyManager.getImage(URL(string: animalImageUrl)!.lastPathComponent)
            if imageViewUnWrapped.image == nil {
                DispatchQueue.global().async {
                    let downloadedImage = self.downloadImg(animalImageUrl as String)
                    DispatchQueue.main.async {
                        imageViewUnWrapped.image = downloadedImage
                        self.persistencyManager.saveImage(downloadedImage, filename: URL(string: animalImageUrl)!.lastPathComponent)
                    }
                }
            }
        }
    }
}
