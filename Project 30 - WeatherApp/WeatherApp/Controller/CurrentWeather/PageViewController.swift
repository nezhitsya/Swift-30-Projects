//
//  PageViewController.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/10/05.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private var currentViewControllers: [CurrentViewController] = [CurrentViewController]()
    var startIndex: Int = 0
    var weatherList: [WeatherInfo] = [WeatherInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupPageView()
        createCurrentWeatherViewController()
        setupFirstPageView()
    }
    
    private func setupPageView() {
        dataSource = self
        delegate = self
    }
    
    private func createCurrentWeatherViewController() {
        var count = 0
        
        for i in weatherList {
            guard let eachPage = currentViewController() as? CurrentViewController else {
                return
            }
            
            eachPage.currentWeatherData = i
            eachPage.currentIndex = count
            eachPage.totalPage = weatherList.count
            currentViewControllers.append(eachPage)
            count += 1
        }
    }
    
    private func setupFirstPageView() {
        let firstViewController = currentViewControllers[startIndex]
        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    private func currentViewController() -> UIViewController {
        let st = UIStoryboard(name: "CurrentWeather", bundle: nil)
        return st.instantiateViewController(withIdentifier: "CurrentViewController")
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

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let current = viewController as? CurrentViewController,
              let viewControllerIndex = currentViewControllers.firstIndex(of: current) else {
                  return nil
              }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0,
              currentViewControllers.count > previousIndex else {
                  return nil
              }
        
        return currentViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let current = viewController as? CurrentViewController,
              let viewControllerIndex = currentViewControllers.firstIndex(of: current) else {
                  return nil
              }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = currentViewControllers.count
        
        guard orderedViewControllersCount != nextIndex,
              orderedViewControllersCount > nextIndex else {
                  return nil
              }
        
        return currentViewControllers[nextIndex]
    }
    
}

extension PageViewController: UIPageViewControllerDelegate {}
