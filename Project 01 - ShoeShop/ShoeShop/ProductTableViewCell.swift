//
//  ProductTableViewCell.swift
//  ShoeShop
//
//  Created by 이다영 on 2021/03/15.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(productImage: String?, productName: String?) {
        
        self.productName.text = productName
        self.productImage.image = UIImage(named: productImage!)
    }
}
