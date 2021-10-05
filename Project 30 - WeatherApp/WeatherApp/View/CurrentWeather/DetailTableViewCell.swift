//
//  DetailTableViewCell.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftDescriptionLabel: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var rightDescriptionLabel: UILabel!
    
    var weatherDetailData: WeatherInfo? {
        didSet {
            guard let speed = weatherDetailData?.wind.speed,
                  let humidity = weatherDetailData?.main.humidity else {
                      return
                  }
            leftDescriptionLabel.text = "\(speed)"
            rightDescriptionLabel.text = "\(humidity)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        leftTitleLabel.text = "Wind"
        rightTitleLabel.text = "Humidity"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
