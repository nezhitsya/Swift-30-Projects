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
            loadPreviousState()
            
            let undoButton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: Selector.undoAction)
            undoButton.isEnabled = false
            
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let trachButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: Selector.deleteAlbum)
            let toolbarButtonItems = [undoButton, space, trachButton]
            
            toolbar.setItems(toolbarButtonItems, animated: true)
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
    
    func loadPreviousState() {
        currentAlbumIndex = UserDefaults.standard.integer(forKey: Constants.indexRestorationKey)
        showDataForAlbum(at: currentAlbumIndex)
    }
    
    func reloadScroller() {
        allAlbums = LibraryAPI.sharedInstance.getAlbum()
        
        if currentAlbumIndex < 0 {
            currentAlbumIndex = 0
        } else if currentAlbumIndex >= allAlbums.count {
            currentAlbumIndex = allAlbums.count - 1
        }
        
        showDataForAlbum(at: currentAlbumIndex)
    }
    
    func addAlbumAtIndex(_ album: Album, index: Int) {
        LibraryAPI.sharedInstance.addAlbum(album, index: index)
        currentAlbumIndex = index
        reloadScroller()
    }

    @objc func saveCurrentState() {
        UserDefaults.standard.set(currentAlbumIndex, forKey: Constants.indexRestorationKey)
        LibraryAPI.sharedInstance.saveAlbums()
    }
    
    @objc func deleteAlbum() {
        
    }
    
    @objc func undoAction() {
        
    }
}

private enum Constants {
    static let cellIdentifier = "Cell"
    static let indexRestorationKey = "currentAlbumIndex"
}

private extension Selector {
    static let saveCurrentState = #selector(ViewController.saveCurrentState)
    static let undoAction = #selector(ViewController.undoAction)
    static let deleteAlbum = #selector(ViewController.deleteAlbum)
}
