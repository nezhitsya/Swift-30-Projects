//
//  ArtistDetailViewController.swift
//  ArtGallery
//
//  Created by 이다영 on 2021/03/26.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    @IBOutlet weak var artTable: UITableView!
    
    let moreInfoText = "More Info > "
    var selectedArtist: Artist!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedArtist.name
        
        artTable.rowHeight = UITableView.automaticDimension
        artTable.estimatedRowHeight = 300
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.main) { [weak self] _ in
            
            self?.artTable.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ArtistDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArtist.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = artTable.dequeueReusableCell(withIdentifier: "ArtCell", for: indexPath) as! ArtTableViewCell
        let work = selectedArtist.works[indexPath.row]
        
        return cell
    }
}
