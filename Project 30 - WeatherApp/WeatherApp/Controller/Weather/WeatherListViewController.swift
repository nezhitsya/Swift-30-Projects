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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
