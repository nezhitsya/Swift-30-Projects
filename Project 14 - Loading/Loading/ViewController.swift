//
//  ViewController.swift
//  Loading
//
//  Created by 이다영 on 2021/04/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
    }

    func startAnimation() {
        image1.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        image2.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        image3.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.image1.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse], animations: {
            self.image2.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.8, options: [.repeat, .autoreverse], animations: {
            self.image3.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

