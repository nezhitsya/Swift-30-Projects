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
        let art = selectedArtist.works[indexPath.row]
        
        cell.artTitle.text = art.title
        cell.artImage.image = art.image
        cell.artTitle.textAlignment = .center
        cell.moreInfo.textColor = UIColor(white: 114/255, alpha: 1)
        cell.selectionStyle = .none
        cell.moreInfo.text = art.isExpanded ? art.info : moreInfoText
        cell.moreInfo.textAlignment = art.isExpanded ? .left : .center
        cell.artTitle.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cell.moreInfo.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        
        return cell
    }
}

extension ArtistDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = artTable.cellForRow(at: indexPath) as? ArtTableViewCell else {
            return
        }
        
        var art = selectedArtist.works[indexPath.row]
        
        art.isExpanded = !art.isExpanded
        selectedArtist.works[indexPath.row] = art
        
        cell.moreInfo.text = art.isExpanded ? art.info : moreInfoText
        cell.moreInfo.textAlignment = art.isExpanded ? .left : .center
        
        artTable.beginUpdates()
        artTable.endUpdates()
        artTable.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
