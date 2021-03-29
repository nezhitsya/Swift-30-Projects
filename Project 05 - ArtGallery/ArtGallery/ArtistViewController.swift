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
        
        artistTable.delegate = self
        artistTable.dataSource = self
        
        artistTable.rowHeight = UITableView.automaticDimension
        artistTable.estimatedRowHeight = 140
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.artistTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? ArtistDetailViewController, let indexPath = artistTable.indexPathForSelectedRow {
//
//            destination.selectedArtist = artists[indexPath.row]
//        }
        if segue.identifier == "segue" {
            if let cell = sender as? UITableViewCell, let indexPath = artistTable.indexPath(for: cell) {
                if let vc = segue.destination as? ArtistDetailViewController {
                    vc.selectedArtist = artists[indexPath.row]
                }
            }
        }
    }
}

extension ArtistViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistTableViewCell
        let artist = artists[indexPath.row]

        cell.bio.text = artist.bio
        cell.bio.textColor = UIColor(white: 114/255, alpha: 1)
        cell.artistImage.image = artist.image
        cell.name.text = artist.name
        cell.name.textColor = UIColor.black
        cell.name.textAlignment = .center
        cell.selectionStyle = .none
        cell.name.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.bio.font = UIFont.preferredFont(forTextStyle: .body)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
}
