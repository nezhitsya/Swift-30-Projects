//
//  ViewController.swift
//  VideoMain
//
//  Created by 이다영 on 2021/04/14.
//

import UIKit

class ViewController: VideoSplashViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoBackground()
    }

    func setupVideoBackground() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp4")!)
        
        videoFrame = view.frame
        alwaysRepeat = true
        sound = true
        startTime = 0.0
        alpha = 0.8
        contentURL = url
        
        view.isUserInteractionEnabled = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

