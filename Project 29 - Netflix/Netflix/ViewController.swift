//
//  ViewController.swift
//  Netflix
//
//  Created by 이다영 on 2021/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainPoster: UIImageView!
    @IBOutlet weak var dramaCollectionView: UICollectionView!
    @IBOutlet weak var horrorCollectionView: UICollectionView!
    @IBOutlet weak var scifiCollectionView: UICollectionView!
    
    private var contents = [Contents]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dramaCollectionView.dataSource = self
        
        mainPoster.addBlackGradientLayerInForeground(frame: mainPoster.frame, colors: [.clear, .black])
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.posterImage.image = UIImage(named: "poster")
        
        return cell
    }
    
}

extension UIView {
    
    func addBlackGradientLayerInForeground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        gradient.locations = [0.0, 1.0]
        self.layer.addSublayer(gradient)
    }
    
}
