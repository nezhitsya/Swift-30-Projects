//
//  Extension+UITableView.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable Dequeue Reusable")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
}

extension UITableViewCell: ReusableCell {}
extension UITableViewCell: NibLoadable {}
