//
//  PlayerViewController.swift
//  Netflix
//
//  Created by 이다영 on 2021/09/21.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    let player = AVPlayer()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { // 오른쪽 랜드스케이프 오른쪽 고정
        return .landscapeRight
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playerView.player = player
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        play()
    }
    
    func play() {
        player.play()
        playButton.isSelected = true
    }
    
    func pause() {
        player.pause()
        playButton.isSelected = false
    }
    
    func reset() {
        player.pause()
        player.replaceCurrentItem(with: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func togglePlayButton(_ sender: Any) {
        if player.isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        reset()
        dismiss(animated: false, completion: nil)
    }

}

extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else {
            return false
        }
        return self.rate != 0
    }
}
