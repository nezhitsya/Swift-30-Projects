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
        return dramaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dramaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        dramaCell.posterImage.image = UIImage(named: "poster")
        
        return dramaCell
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
