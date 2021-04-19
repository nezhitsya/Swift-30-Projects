//
//  ViewController.swift
//  PhotoList
//
//  Created by 이다영 on 2021/04/16.
//

import UIKit
import CoreImage

let imageURL = URL(string: "https://docs.google.com/uc?export=download&id=17PIXTSkqLGUx53bOo_LflDyMGDF0HfoW")
//let imageURL = URL(string: "http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist")

class ViewController: UITableViewController {
    
    var photos = [PhotoRecord]()
    let pendingOperations = PendingOperations()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photos"
        
        fetchPhotoDetails()
    }
    
    private func fetchPhotoDetails() {
        let request = URLRequest(url: imageURL!)

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in

            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)

                return
            }

            if let data = data {
                do {
                    if let datasourceDictionary = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions(rawValue: 0), format: nil) as? [String: AnyObject] {

                        for (name, url) in datasourceDictionary {
                            if let url = URL(string: url as! String) {
                                let photoRecord = PhotoRecord(name: name, url: url)

                                self.photos.append(photoRecord)
                            }
                        }
                        self.tableView.reloadData()
                    }
                } catch let error as NSError {
                    print(error.domain)
                }
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    private func startDownloadForRecord(photoDetails: PhotoRecord, indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
        let downloader = ImageDownloader(photoRecord: photoDetails)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    private func startFiltrationForRecord(photoDetails: PhotoRecord, indexPath: IndexPath) {
        if let _ = pendingOperations.filtrationsInProgress[indexPath] {
            return
        }
        
        let filterer = ImageFiltration(photoRecord: photoDetails)
        
        filterer.completionBlock = {
            if filterer.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        pendingOperations.filtrationsInProgress[indexPath] = filterer
        pendingOperations.filtrationQueue.addOperation(filterer)
    }
    
    private func startOperationsForPhotoRecord(photoDetails: PhotoRecord, indexPath: IndexPath) {
        switch (photoDetails.state) {
        case .New:
            startDownloadForRecord(photoDetails: photoDetails, indexPath: indexPath)
        case .Downloaded:
            startFiltrationForRecord(photoDetails: photoDetails, indexPath: indexPath)
        default:
            NSLog("do nothing")
        }
    }
    
    private func loadImagesForOnscreenCells() {
        if let pathsArray = tableView.indexPathsForVisibleRows {
            var allPendingOperations = Set(pendingOperations.downloadsInProgress.keys)
            
            allPendingOperations = allPendingOperations.union(pendingOperations.filtrationsInProgress.keys)
            
            var toBeCancelled = allPendingOperations
            let visiblePath = Set(pathsArray)
            toBeCancelled.subtract(visiblePath)
            
            var toBeStarted = visiblePath
            toBeStarted.subtract(allPendingOperations)
            
            for indexPath in toBeCancelled {
                if let pendingDownload = pendingOperations.downloadsInProgress[indexPath] {
                    pendingDownload.cancel()
                }
                pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                
                if let pendingFiltration = pendingOperations.filtrationsInProgress[indexPath] {
                    pendingFiltration.cancel()
                }
                pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
            }
            
            for indexPath in toBeStarted {
                let recordToProcess = self.photos[indexPath.row]
                
                startOperationsForPhotoRecord(photoDetails: recordToProcess, indexPath: indexPath)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("okokoko")
        print(photos.count)
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if cell.accessoryView == nil {
            let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            
            cell.accessoryView = indicator
        }
        
        let indicator = cell.accessoryView as! UIActivityIndicatorView
        let photoDetails = photos[indexPath.row]
        
        cell.textLabel?.text = photoDetails.name
        cell.imageView?.image = photoDetails.image
        
        switch (photoDetails.state) {
        case .Filtered:
            indicator.stopAnimating()
        case.Failed:
            indicator.stopAnimating()
            cell.textLabel?.text = "Failed to load"
        case .New, .Downloaded:
            indicator.startAnimating()
            
            if (!tableView.isDragging && !tableView.isDecelerating) {
                self.startOperationsForPhotoRecord(photoDetails: photoDetails, indexPath: indexPath)
            }
        }

        return cell
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pendingOperations.downloadQueue.isSuspended = true
        pendingOperations.filtrationQueue.isSuspended = true
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadImagesForOnscreenCells()
            
            pendingOperations.downloadQueue.isSuspended = false
            pendingOperations.filtrationQueue.isSuspended = false
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenCells()
        
        pendingOperations.downloadQueue.isSuspended = false
        pendingOperations.filtrationQueue.isSuspended = false
    }
}

