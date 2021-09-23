//
//  ViewController.swift
//  Netflix
//
//  Created by 이다영 on 2021/06/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var mainPoster: UIImageView!
    @IBOutlet weak var dramaCollectionView: UICollectionView!
    @IBOutlet weak var horrorCollectionView: UICollectionView!
    @IBOutlet weak var scifiCollectionView: UICollectionView!
    
    private var persistencyManager: PersistencyManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        persistencyManager = PersistencyManager()
        
        mainPoster.addBlackGradientLayerInForeground(frame: mainPoster.frame, colors: [.clear, .black])
        
        self.dramaCollectionView.dataSource = self
        self.horrorCollectionView.dataSource = self
        self.scifiCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "drama" {
            if let cell = sender as? UICollectionViewCell,
               let indexPath = dramaCollectionView?.indexPath(for: cell),
               let detail = segue.destination as? DetailViewController {
                detail.dramaList = persistencyManager.dramaList[indexPath.row]
            }
        } else if segue.identifier == "horror" {
            if let cell = sender as? UICollectionViewCell,
               let indexPath = horrorCollectionView?.indexPath(for: cell),
               let detail = segue.destination as? DetailViewController {
                detail.horrorList = persistencyManager.horrorList[indexPath.row]
            }
        } else {
            if let cell = sender as? UICollectionViewCell,
               let indexPath = scifiCollectionView?.indexPath(for: cell),
               let detail = segue.destination as? DetailViewController {
                detail.scifiList = persistencyManager.scifiList[indexPath.row]
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.dramaCollectionView {
            return persistencyManager.dramaList.count
        } else if collectionView == self.horrorCollectionView {
            return persistencyManager.horrorList.count
        } else {
            return persistencyManager.scifiList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.dramaCollectionView {
            let dramaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dramaCell", for: indexPath) as! CollectionViewCell
            
            let imageURL = URL(string: persistencyManager.dramaList[(indexPath as NSIndexPath).item].poster)
            if let imageData = try? Data(contentsOf: imageURL!) {
                dramaCell.posterImage.image = UIImage(data: imageData)
            }
            
            return dramaCell
        } else if collectionView == self.horrorCollectionView {
            let horrorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "horrorCell", for: indexPath) as! CollectionViewCell
            
            let imageURL = URL(string: persistencyManager.horrorList[(indexPath as NSIndexPath).item].poster)
            if let imageData = try? Data(contentsOf: imageURL!) {
                horrorCell.posterImage.image = UIImage(data: imageData)
            }
            
            return horrorCell
        } else {
            let scifiCell = collectionView.dequeueReusableCell(withReuseIdentifier: "scifiCell", for: indexPath) as! CollectionViewCell
            
            let imageURL = URL(string: persistencyManager.scifiList[(indexPath as NSIndexPath).item].poster)
            if let imageData = try? Data(contentsOf: imageURL!) {
                scifiCell.posterImage.image = UIImage(data: imageData)
            }
            
            return scifiCell
        }
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
