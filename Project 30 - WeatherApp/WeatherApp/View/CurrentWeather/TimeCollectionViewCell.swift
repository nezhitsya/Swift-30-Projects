//
//  TimeCollectionViewCell.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/10/04.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(weather data: Weather) {
        descriptionLabel.text = data.description
        iconImageView.image = UIImage(named: data.icon)
    }

}
