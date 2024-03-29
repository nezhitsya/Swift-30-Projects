//
//  WeatherListSettingTableViewCell.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/10/11.
//

import UIKit

class WeatherListSettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var toggleButton: UIButton!
    
    private var fahrenheitOrCelsius: FahrenheitOrCelsius? {
        didSet {
            UserDefaults.standard.set(fahrenheitOrCelsius?.rawValue,
                                      forKey: UserInfo.fahrenheitOrCelsius)
        }
    }
    
    var delegate: fahrenheitOrCelsiusDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fetchFahrenheitOrCelsius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func fetchFahrenheitOrCelsius() {
        fahrenheitOrCelsius = UserInfo.getFahrenheitOrCelsius()
    }
    
    @IBAction func celsiusFahrenheitButtonClicked(_ sender: UIButton) {
        guard let fahrenheitOrCelsius = fahrenheitOrCelsius else {
            return
        }
        
        switch fahrenheitOrCelsius {
        case .Fahrenheit:
            delegate?.selectFahrenheitOrCelsius(name: .Celsius)
            self.fahrenheitOrCelsius = .Celsius
        case .Celsius:
            delegate?.selectFahrenheitOrCelsius(name: .Fahrenheit)
            self.fahrenheitOrCelsius = .Fahrenheit
        }
    }
    
    @IBAction func findCityButtonClicked(_ sender: UIButton) {
        let st = UIStoryboard.init(name: "SearchCity", bundle: nil)
        guard let vc = st.instantiateViewController(withIdentifier: "SearchCityViewController") as? SearchCityViewController else {
            return
        }
        
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func webButtonClicked(_ sender: UIButton) {
        guard let webURL = URL(string: BaseURL.webURL) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(webURL)
        }
    }
    
}
