//
//  ViewController.swift
//  Music
//
//  Created by 이다영 on 2021/04/20.
//

import UIKit

class ViewController: UIViewController {
    
    private var allAlbums = [Album]()
    private var currentAlbumData: [AlbumData]?
    private var currentAlbumIndex = 0
    private var undoStack: [(Album, Int)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: Selector.saveCurrentState, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    @objc func saveCurrentState() {
        UserDefaults.standard.set(currentAlbumIndex, forKey: Constants.indexRestorationKey)
        LibraryAPI.sharedInstance.saveAlbums()
    }
}

private enum Constants {
    static let cellIdentifier = "Cell"
    static let indexRestorationKey = "currentAlbumIndex"
}

private extension Selector {
    static let saveCurrentState = #selector(ViewController.saveCurrentState)
}
