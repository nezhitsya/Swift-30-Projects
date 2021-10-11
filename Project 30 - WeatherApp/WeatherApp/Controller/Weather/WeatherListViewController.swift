//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/10/09.
//

import UIKit
import WebKit
import CoreLocation

class WeatherListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let locationManager: CLLocationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var allowPermission: Bool = false
    private var weather: [WeatherInfo] = [WeatherInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var fahrenheitOrCelsius: FahrenheitOrCelsius? = UserInfo.getFahrenheitOrCelsius() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var myCities: [Coordinate] = [Coordinate]() {
        didSet {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.myCities),
                                      forKey: UserInfo.cities)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refreshData),
                                 for: .valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        getCoordinate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewController()
        registerNib()
        createObserver()
        fetchCityList()
    }
    
    private func fetchCityList() {
        guard let cities = UserInfo.getCityList() else {
            return
        }
        
        myCities = cities
        DispatchQueue.global().async {
            self.myCities.forEach({
                self.getWeatherByCoordinate(latitude: $0.lat,
                                            longtitude: $0.lon)
            })
        }
    }
    
    private func setupViewController() {
        tableView.addSubview(refreshControl)
        registerForPreviewing(with: self, sourceView: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
    }
    
    private func registerNib() {
        
    }
    
    private func createObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(selectedCity),
                                               name: .selectCity,
                                               object: nil)
    }
    
    private func getCoordinate() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func getWeatherByCoordinate(latitude lat: Double, longtitude lon: Double) {
        let parameters: [String: Any] = [
            "lat" : "\(lat)",
            "lon" : "\(lon)",
            "appid" : weatherAPIKey
        ]
        
        let request = APIRequest(method: .get,
                                 path: BasePath.list,
                                 queryItems: parameters)
        
        
    }
    
    private func checkCurrentLocationOrNot(bodyData: WeatherInfo) {
        guard let coordinate = currentLocation?.coordinate else {
            if !allowPermission {
                weather.append(bodyData)
            }
            return
        }
        
        if bodyData.name == weather.first?.name {
            return
        }
        
        if coordinate.latitude.makeRound() == bodyData.coord.lat,
           coordinate.longitude.makeRound() == bodyData.coord.lon {
            weather.insert(bodyData, at: 0)
        } else {
            weather.append(bodyData)
        }
    }
    
    @objc private func selectedCity(notification: NSNotification) {
        guard let cityCoordinate = notification.object as? CLLocationCoordinate2D else {
            return
        }
        
        if !myCities.contains(Coordinate(lat: cityCoordinate.latitude.makeRound(),
                                         lon: cityCoordinate.longitude.makeRound())) {
            getWeatherByCoordinate(latitude: cityCoordinate.latitude,
                                   longtitude: cityCoordinate.longitude)
            myCities.append(Coordinate(lat: cityCoordinate.latitude.makeRound(),
                                       lon: cityCoordinate.longitude.makeRound()))
        }
    }
    
    @objc private func selectedFahrenheitOrCelsius(notification: NSNotification) {
        fahrenheitOrCelsius = notification.object as? FahrenheitOrCelsius
    }
    
    @objc private func refreshData() {
        guard let coordinate = currentLocation?.coordinate else {
            return
        }
        
        weather.removeAll()
        DispatchQueue.global().async {
            self.getWeatherByCoordinate(latitude: coordinate.latitude.makeRound(),
                                        longtitude: coordinate.longitude.makeRound())
            self.fetchCityList()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
