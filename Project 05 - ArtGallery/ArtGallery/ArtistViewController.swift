//
//  ViewController.swift
//  ArtGallery
//
//  Created by 이다영 on 2021/03/25.
//

import UIKit

class ArtistViewController: UIViewController {
    
    @IBOutlet weak var artistTable: UITableView!

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
            
        }
    }
}
