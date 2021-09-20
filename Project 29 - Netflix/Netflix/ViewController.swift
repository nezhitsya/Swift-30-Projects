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
    private var dramaList = [Drama]()
    private var scifiList = [SciFi]()
    private var horrorList = [Horror]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dramaCollectionView.dataSource = self
        horrorCollectionView.dataSource = self
        scifiCollectionView.dataSource = self
        
        mainPoster.addBlackGradientLayerInForeground(frame: mainPoster.frame, colors: [.clear, .black])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parseJSON()
    }
    
    func parseJSON() {

        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/reactnative-a1712.appspot.com/o/movies.json?alt=media&token=6b700211-da8f-426d-bf3a-fe0b106dcb71") else {
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
                                
                                print(self.dramaList[1].casting)
                            }
                        }
                    }
                }
            }
        }.resume()
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
            
            for i in 0...self.dramaList.count {
                let imageURL = URL(string: self.dramaList[i].poster)
                if let imageData = try? Data(contentsOf: imageURL!) {
                    dramaCell.posterImage.image = UIImage(data: imageData)
                }
            }
            
            dramaCell.posterImage.image = UIImage(named: "poster")
            
            return dramaCell
        } else if collectionView == self.horrorCollectionView {
            let horrorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "horrorCell", for: indexPath) as! CollectionViewCell
            
            horrorCell.posterImage.image = UIImage(named: "logo")
            
            return horrorCell
        } else {
            let scifiCell = collectionView.dequeueReusableCell(withReuseIdentifier: "scifiCell", for: indexPath) as! CollectionViewCell
            
            scifiCell.posterImage.image = UIImage(named: "logoN")
            
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
