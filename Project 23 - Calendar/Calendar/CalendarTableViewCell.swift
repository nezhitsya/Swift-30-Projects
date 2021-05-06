//
//  CalendarTableViewCell.swift
//  Calendar
//
//  Created by 이다영 on 2021/05/06.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var email: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contactImage.layer.cornerRadius = 25.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
