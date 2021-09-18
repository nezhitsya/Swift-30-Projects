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
    var contentsList: Contents!
    var dramaList: [String] = []
    var scifiList: [String] = []
    var horrorList: [String] = []

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
        guard let url = URL(string: "https://raw.githubusercontent.com/nezhitsya/Swift-30-Projects/master/Project%2029%20-%20Netflix/contents.json") else {
            print("api is down")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil && data != nil {
                do {
                    if let response = try? JSONDecoder().decode(Contents.self, from: data!) {
                        DispatchQueue.main.async {
                            self.contentsList = response
                            if self.contentsList.genre == "drama" {
                                self.dramaList.append(self.contentsList.title)
                            } else if self.contentsList.genre == "horror" {
                                self.horrorList.append(self.contentsList.title)
                            } else {
                                self.scifiList.append(self.contentsList.title)
                            }
                        }
                    }
                }
            }
        }
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
                if self.contentsList.title == self.dramaList[i] {
                    dramaCell.posterImage.image = UIImage(named: "logo")
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
