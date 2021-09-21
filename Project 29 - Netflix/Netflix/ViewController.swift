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
    
    private var contentsList: Movies!
    var dramaList = [Drama]()
    var scifiList = [SciFi]()
    var horrorList = [Horror]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPoster.addBlackGradientLayerInForeground(frame: mainPoster.frame, colors: [.clear, .black])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parseJSON()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "drama" {
            if let cell = sender as? UICollectionViewCell,
               let indexPath = dramaCollectionView?.indexPath(for: cell),
               let detail = segue.destination as? DetailViewController {
                detail.dramaList = self.dramaList[indexPath.row]
            }
        } else if segue.identifier == "horror" {
            if let cell = sender as? UICollectionViewCell,
               let indexPath = horrorCollectionView?.indexPath(for: cell),
               let detail = segue.destination as? DetailViewController {
                detail.horrorList = self.horrorList[indexPath.row]
            }
        } else {
            if let cell = sender as? UICollectionViewCell,
               let indexPath = scifiCollectionView?.indexPath(for: cell),
               let detail = segue.destination as? DetailViewController {
                detail.scifiList = self.scifiList[indexPath.row]
            }
        }
    }
    
    func parseJSON() {

        guard let url = URL(string: "https://raw.githubusercontent.com/nezhitsya/Swift-30-Projects/master/Project%2029%20-%20Netflix/movies.json") else {
            print("api is down")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil && data != nil {
                do {
                    DispatchQueue.main.async {
//                        print(String(data: data!, encoding: .utf8) ?? "")
                        
                        if let response = try? JSONDecoder().decode(Movies.self, from: data!) {
                            DispatchQueue.main.async {
                                self.contentsList = response
                                self.dramaList = self.contentsList.Drama
                                self.horrorList = self.contentsList.Horror
                                self.scifiList = self.contentsList.SciFi
                                
                                self.dramaCollectionView.dataSource = self
                                self.horrorCollectionView.dataSource = self
                                self.scifiCollectionView.dataSource = self
                            }
                        }
                    }
                }
            }
        }.resume()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.dramaCollectionView {
            return self.dramaList.count
        } else if collectionView == self.horrorCollectionView {
            return self.horrorList.count
        } else {
            return self.scifiList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.dramaCollectionView {
            let dramaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dramaCell", for: indexPath) as! CollectionViewCell
            
            let imageURL = URL(string: self.dramaList[(indexPath as NSIndexPath).item].poster)
            if let imageData = try? Data(contentsOf: imageURL!) {
                dramaCell.posterImage.image = UIImage(data: imageData)
            }
            
            return dramaCell
        } else if collectionView == self.horrorCollectionView {
            let horrorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "horrorCell", for: indexPath) as! CollectionViewCell
            
            let imageURL = URL(string: self.horrorList[(indexPath as NSIndexPath).item].poster)
            if let imageData = try? Data(contentsOf: imageURL!) {
                horrorCell.posterImage.image = UIImage(data: imageData)
            }
            
            return horrorCell
        } else {
            let scifiCell = collectionView.dequeueReusableCell(withReuseIdentifier: "scifiCell", for: indexPath) as! CollectionViewCell
            
            let imageURL = URL(string: self.scifiList[(indexPath as NSIndexPath).item].poster)
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
