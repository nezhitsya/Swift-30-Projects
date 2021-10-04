//
//  CurrentViewController.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/28.
//

import UIKit

class CurrentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentWeatherData: WeatherInfo?
    var currentIndex: Int = 0
    var totalPage: Int = 0
    
    private var fiveDayWeatherData: FiveDayWeather? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var fahrenheitOrCelsius: FahrenheitOrCelsius? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
        setupTableView()
        fetchFahrenheitOrCelsius()
    }
    
    private func fetchFahrenheitOrCelsius() {
        fahrenheitOrCelsius = UserInfo.getFahrenheitOrCelsius()
    }
    
    private func fetchData() {
        guard let coordinate = currentWeatherData?.coord else {
            return
        }
        self.get5DayWeatherByCoordinate(latitude: coordinate.lat,
                                        longitude: coordinate.lon)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func get5DayWeatherByCoordinate(latitude lat: Double, longitude lon: Double) {
        let parameters: [String: Any] = [
            "lat" : "\(lat)",
            "lon" : "\(lon)",
            "appid" : weatherAPIKey
        ]
        
        let request = APIRequest(method: .get,
                                 path: BasePath.current,
                                 queryItems: parameters)
        
        APICenter().perform(urlString: BaseURL.weatherURL,
                            request: request) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let response):
                if let response = try? response.decode(to: FiveDayWeather.self) {
                    self.fiveDayWeatherData = response.body
                } else {
                    print(APIError.decodingFailed)
                }
            case .failure:
                print(APIError.networkFailed)
            }
        }
    }
    
    private func updateUI() {
        guard let weahter = currentWeatherData,
              let fahrenheitOrCelsius = fahrenheitOrCelsius else {
            return
        }
        
        switch fahrenheitOrCelsius {
        case .Celsius:
            tempLabel.text = weahter.main.temp.makeCelsius()
            maxTempLabel.text = weahter.main.tempMax.makeCelsius()
            minTempLabel.text = weahter.main.tempMin.makeCelsius()
        case .Fahrenheit:
            tempLabel.text = weahter.main.temp.makeFahrenheit()
            maxTempLabel.text = weahter.main.tempMax.makeFahrenheit()
            minTempLabel.text = weahter.main.tempMin.makeFahrenheit()
        }
        
        cityNameLabel.text = weahter.name
        dayLabel.text = calculateDay()
        weatherStatusLabel.text = weahter.weather.first?.description
        pageControl.numberOfPages = totalPage
        pageControl.currentPage = currentIndex
    }
    
    private func calculateDay() -> String {
        guard let timezone = currentWeatherData?.timezone,
              let date = Date().dayNumberOfWeek(time: timezone),
              let day = Week(rawValue: date) else {
            return ""
        }
        return day.StringValue
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func listButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func webButtonClicked(_ sender: UIButton) {
        guard let webURL = URL(string: BaseURL.webURL) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(webURL,
                                      options: [:],
                                      completionHandler: nil)
        } else {
            UIApplication.shared.openURL(webURL)
        }
    }

}

extension CurrentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = fiveDayWeatherData?.list else {
            return 1
        }
        return list.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = CurrentCellType(rawValue: indexPath.row) ?? .DaysCell
        
        if cellType.cellType == CurrentWeatherTimesTableViewCell.self {
            let cell: CurrentWeatherTimesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            guard let weatherData = currentWeatherData?.weather else {
                return UITableViewCell()
            }
            cell.weatherList = weatherData
            return cell
        } else if cellType.cellType == DetailTableViewCell.self {
            let cell: DetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            guard let weatherData = currentWeatherData else {
                return UITableViewCell()
            }
            
            return cell
        } else {
            let cell: DaysTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            guard let list = fiveDayWeatherData?.list,
                  let fahrenheitOrCelsiusData = fahrenheitOrCelsius else {
                return UITableViewCell()
            }
            cell.config(weather: list[indexPath.row - 2],
                        fahrenheitOrCelsius: fahrenheitOrCelsiusData)
            return cell
        }
    }
}
