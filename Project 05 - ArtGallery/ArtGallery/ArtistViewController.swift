//
//  ViewController.swift
//  ArtGallery
//
//  Created by 이다영 on 2021/03/25.
//

import UIKit

class ArtistViewController: UIViewController {
    
    @IBOutlet weak var artistTable: UITableView!
    
    let artists = Artist.artistsFromBundle()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistTable.rowHeight = UITableView.automaticDimension
        artistTable.estimatedRowHeight = 140
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.artistTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArtistDetailViewController, let indexPath = artistTable.indexPathForSelectedRow {
            
            destination.selectedArtist = artists[indexPath.row]
        }
    }
}

extension ArtistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistTableViewCell
        
        return cell
    }
}
