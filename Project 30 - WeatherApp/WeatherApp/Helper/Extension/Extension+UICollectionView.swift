//
//  Extension+UICollectionView.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/10/04.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Unable Dequeue Reusable")
        }
        
        return cell
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
}

extension UICollectionViewCell: ReusableCell {}
extension UICollectionViewCell: NibLoadable {}
