//
//  ViewController.swift
//  Music
//
//  Created by 이다영 on 2021/04/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var dataTable: UITableView!
    @IBOutlet var toolbar: UIToolbar!
    
    private var allAlbums = [Album]()
    private var currentAlbumData: [AlbumData]?
    private var currentAlbumIndex = 0
    private var undoStack: [(Album, Int)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        func setUI() {
            navigationController?.navigationBar.isTranslucent = false
        }
        
        func setData() {
            currentAlbumIndex = 0
            allAlbums = LibraryAPI.sharedInstance.getAlbum()
        }
        
        func setComponents() {
            dataTable.backgroundView = nil
            
        }
        
        setUI()
        setData()
        setComponents()
        showDataForAlbum(at: currentAlbumIndex)
        
        NotificationCenter.default.addObserver(self, selector: Selector.saveCurrentState, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func showDataForAlbum(at index: Int) {
        if index < allAlbums.count && index > -1 {
            let album = allAlbums[index]
            currentAlbumData = album.tableRepresentation
        } else {
            currentAlbumData = nil
        }
        dataTable.reloadData()
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
