//
//  DetailViewController.swift
//  Netflix
//
//  Created by 이다영 on 2021/09/20.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var casting: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    var dramaList: Drama!
    var horrorList: Horror!
    var scifiList: SciFi!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        poster.addBlackGradientLayerInForeground(frame: poster.frame, colors: [.clear, .black])
        
        if dramaList != nil {
            contentTitle.text = dramaList.title
            contents.text = dramaList.explain
            casting.text = dramaList.casting
            let imageURL = URL(string: self.dramaList.poster)
            if let imageData = try? Data(contentsOf: imageURL!) {
                poster.image = UIImage(data: imageData)
            }
        } else if horrorList != nil {
            contentTitle.text = horrorList.title
            contents.text = horrorList.explain
            casting.text = horrorList.casting
            let imageURL = URL(string: self.horrorList.poster)
            if let imageData = try? Data(contentsOf: imageURL!) {
                poster.image = UIImage(data: imageData)
            }
        } else {
            contentTitle.text = scifiList.title
            contents.text = scifiList.explain
            casting.text = scifiList.casting
            let imageURL = URL(string: self.scifiList.poster)
            if let imageData = try? Data(contentsOf: imageURL!) {
                poster.image = UIImage(data: imageData)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func playButtonTapped(_ sender: Any) {
        let url = URL(string: dramaList.poster)!
        let item = AVPlayerItem(url: url)
        let sb = UIStoryboard(name: "Player", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        
//        vc.modalTransitionStyle = .fullScreen
        vc.player.replaceCurrentItem(with: item)
        
        self.present(vc, animated: false, completion: nil)
    }

}
