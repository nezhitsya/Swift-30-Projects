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
        
        artTable.delegate = self
        artTable.dataSource = self

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
        
        cell.artTitle.text = work.title
        cell.artImage.image = work.image
        cell.artTitle.textAlignment = .center
        cell.moreInfo.textColor = UIColor(white: 114/255, alpha: 1)
        cell.selectionStyle = .none
        cell.moreInfo.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfo.textAlignment = work.isExpanded ? .left : .center
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
        
        var work = selectedArtist.works[indexPath.row]
        
        work.isExpanded = !work.isExpanded
        selectedArtist.works[indexPath.row] = work
        
        cell.moreInfo.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfo.textAlignment = work.isExpanded ? .left : .center
        
        artTable.beginUpdates()
        artTable.endUpdates()
        artTable.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
