//
//  MainTableViewCell.swift
//  Dictionary
//
//  Created by 이다영 on 2021/03/31.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalType: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    
    private var indicator: UIActivityIndicatorView!

    func awakeFromNib(_ type: String, name: String, animalImageUrl: String) {
        super.awakeFromNib()
        
        setupUI(type, name: name)
        setupNotification(animalImageUrl)
    }
    
    deinit {
        animalImage.removeObserver(self, forKeyPath: "image")
    }
    
    private func setupNotification(_ animalImageUrl: String) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: downloadImageNotification), object: self, userInfo: ["animalImageView": animalImage!, "animImageUrl": animalImageUrl])
    }
    
    private func setupUI(_ type: String, name: String) {
        animalName.text = name
        animalType.text = type
//        animalImage.image = UIImage(named: "default")
        
        indicator = UIActivityIndicatorView()
        indicator.center = CGPoint(x: animalImage.bounds.midX, y: animalImage.bounds.midY)
        indicator.startAnimating()
        
        animalImage.addSubview(indicator)
        animalImage.addObserver(self, forKeyPath: "image", options: [], context: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "image" {
            indicator.stopAnimating()
        }
    }

}
