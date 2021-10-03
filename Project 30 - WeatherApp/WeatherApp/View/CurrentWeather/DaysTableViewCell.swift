//
//  DaysTableViewCell.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    
    var weatherDayList: List? {
        didSet {
            guard let dayTime = weatherDayList?.dtTxt,
                  let iconName = weatherDayList?.weather.first?.icon else {
                      return
                  }
            dateLabel.text = getDayString(getData: dayTime)
            weatherIconImageView.image = UIImage(named: iconName)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getDayString(getData: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let formatDate = dateFormatter.date(from: getData),
              let dayCnt = formatDate.dayNumberOfWeek(),
              let day = Week(rawValue: dayCnt) else {
                  return " "
              }
        return day.StringValue
    }
    
    func config(weather data: List, fahrenheitOrCelsius: FahrenheitOrCelsius) {
        weatherDayList = data
        
        let emoji = fahrenheitOrCelsius.emoji
        
        switch fahrenheitOrCelsius {
        case .Celsius:
            tempMaxLabel.text = data.main.tempMin.makeCelsius() + emoji
            tempMinLabel.text = data.main.tempMin.makeCelsius() + emoji
        case .Fahrenheit:
            tempMaxLabel.text = data.main.tempMax.makeFahrenheit() + emoji
            tempMinLabel.text = data.main.tempMin.makeFahrenheit() + emoji
        }
    }
    
}
