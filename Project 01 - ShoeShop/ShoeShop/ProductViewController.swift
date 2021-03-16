//
//  ProductViewController.swift
//  ShoeShop
//
//  Created by 이다영 on 2021/03/15.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        productName.text = product?.name
        
        if let imageName = product?.fullscreenImage {
            productImage.image = UIImage(named: imageName)
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
