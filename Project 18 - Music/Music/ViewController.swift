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
        
        self.dataTable.dataSource = self
        
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
        let deletedAlbum: Album = allAlbums[currentAlbumIndex]
        let undoAction = (deletedAlbum, currentAlbumIndex)
        
        undoStack.insert(undoAction, at: 0)
        LibraryAPI.sharedInstance.deleteAlbum(currentAlbumIndex)
        reloadScroller()
        
        let barButtonItems = toolbar.items! as [UIBarButtonItem]
        let undoButton: UIBarButtonItem = barButtonItems[0]
        undoButton.isEnabled = true
        
        if (allAlbums.count == 0) {
            let trashButton: UIBarButtonItem = barButtonItems[2]
            trashButton.isEnabled = false
        }
    }
    
    @objc func undoAction() {
        let barButtonItems = toolbar.items! as [UIBarButtonItem]
        
        if undoStack.count > 0 {
            let (deletedAlbum, index) = undoStack.remove(at: 0)
            addAlbumAtIndex(deletedAlbum, index: index)
        }
        
        if undoStack.count == 0 {
            let undoButton: UIBarButtonItem = barButtonItems[0]
            undoButton.isEnabled = false
        }
        
        let trashButton: UIBarButtonItem = barButtonItems[2]
        trashButton.isEnabled = true
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let albumData = currentAlbumData {
            return albumData.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        if let albumData = currentAlbumData {
            cell.textLabel?.text = albumData[(indexPath as NSIndexPath).row].title
            cell.detailTextLabel?.text = albumData[(indexPath as NSIndexPath).row].value
        }
        
        return cell
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
