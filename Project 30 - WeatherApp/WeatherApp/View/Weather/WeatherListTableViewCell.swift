//
//  WeatherListTableViewCell.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/10/11.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var weatherData: WeatherInfo?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        Timer.scheduledTimer(timeInterval: 60,
                             target: self,
                             selector: #selector(updateTime),
                             userInfo: nil,
                             repeats: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(weatherInfoData: WeatherInfo, fahrenheitOrCelsius: FahrenheitOrCelsius) {
        weatherData = weatherInfoData
        updateTime()
        cityNameLabel.text = weatherInfoData.name
        
        switch fahrenheitOrCelsius {
        case .Celsius:
            temperatureLabel.text = weatherInfoData.main.temp.makeCelsius() + fahrenheitOrCelsius.emoji
        case .Fahrenheit:
            temperatureLabel.text = weatherInfoData.main.temp.makeFahrenheit() + fahrenheitOrCelsius.emoji
        }
    }
    
    @objc private func updateTime() {
        guard let timezone = weatherData?.timezone else {
            return
        }
        
        timeLabel.text = Date().getCountryTime(byTimeZone: timezone)
    }
    
}
