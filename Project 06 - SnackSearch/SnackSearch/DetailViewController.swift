//
//  ViewController.swift
//  SnackSearch
//
//  Created by 이다영 on 2021/03/29.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var SnackImage: UIImageView!
    @IBOutlet weak var SnackName: UILabel!
    @IBOutlet weak var SnackCategory: UILabel!
    
    var detailSnack: Snack? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        if let detailSnack = detailSnack {
            if let SnackName = SnackName, let SnackImage = SnackImage {
                SnackName.text = detailSnack.name
                SnackImage.image = UIImage(named: detailSnack.name)
                SnackCategory.text = detailSnack.category
                
                title = detailSnack.category
            }
        }
    }
}

