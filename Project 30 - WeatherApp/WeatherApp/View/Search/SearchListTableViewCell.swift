//
//  SearchListTableViewCell.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/10/08.
//

import UIKit
import MapKit

class SearchListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var searchData: MKLocalSearchCompletion? {
        didSet {
            guard let city = searchData else {
                return
            }
            
            cityNameLabel.attributedText = highlightedText(city.title,
                                                           inRanges: city.titleHighlightRanges,
                                                           size: 17.0)
        }
    }
    
    func config(data: MKLocalSearchCompletion) {
        searchData = data
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func highlightedText(_ text: String, inRanges ranges: [NSValue], size: CGFloat) -> NSAttributedString? {
        let attributeText = NSMutableAttributedString(string: text)
        
        if let bold = UIFont(name: "AppleSDGothicNeo-Bold", size: size) {
            for value in ranges {
                attributeText.addAttribute(NSAttributedString.Key.font,
                                            value: bold,
                                            range: value.rangeValue)
            }
            
            return attributeText
        }
        
        return nil
    }
    
}
