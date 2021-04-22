//
//  LibraryAPI.swift
//  Music
//
//  Created by 이다영 on 2021/04/23.
//

import UIKit

class LibraryAPI: NSObject {
    static let sharedInstance = LibraryAPI()
    
    private let persistencyManager: PersistencyManager
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    private override init() {
        
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = false
            
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: .downloadImage, name: .BLDownloadImage, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getAlbum() -> [Album] {
        return persistencyManager.getAlbums()
    }
    
    func addAlbum(_ album: Album, index: Int) {
        persistencyManager.addAlbum(album, index: index)
        
        if isOnline {
            let _ = httpClient.postRequest("/api/addAlbum", body: album.description)
        }
    }
    
    func deleteAlbum(_ index: Int) {
        persistencyManager.deleteAlbumAtIndex(index)
        
        if isOnline {
            let _ = httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }
    
    @objc func downloadImage(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let imageView = userInfo["imageView"] as? UIImageView,
              let coverUrl = userInfo["coverUrl"] as? String,
              let filename = URL(string: coverUrl)?.lastPathComponent else {
            return
        }
        
        if let savedImage = persistencyManager.getImage(with: filename) {
            imageView.image = savedImage
            return
        }
        
        DispatchQueue.global().async {
            let downloadImage = self.httpClient.downloadImage(coverUrl as String)
            
            DispatchQueue.main.async {
                imageView.image = downloadImage
                self.persistencyManager.saveImage(downloadImage, filename: URL(string: coverUrl)!.lastPathComponent)
            }
        }
    }
    
    func saveAlbums() {
        persistencyManager.saveAlbums()
    }
}

extension Selector {
    static let downloadImage = #selector(LibraryAPI.downloadImage(_:))
}
