//
//  CurrentWeatherTimesTableViewCell.swift
//  WeatherApp
//
//  Created by 이다영 on 2021/09/29.
//

import UIKit

class CurrentWeatherTimesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherList: [Weather] = [Weather]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCollectionView()
        registerNib()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerNib() {
        collectionView.register(TimeCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CurrentWeatherTimesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.reuseIdentifier, for: indexPath) as? TimeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.config(weather: weatherList[indexPath.row])
        return cell
    }
    
}
