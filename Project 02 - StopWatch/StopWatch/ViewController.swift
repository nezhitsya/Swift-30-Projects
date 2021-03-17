//
//  ViewController.swift
//  StopWatch
//
//  Created by 이다영 on 2021/03/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let laps: [String] = []
    
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var lapTimer: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var lapResetBtn: UIButton!
    @IBOutlet weak var lapsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initCircleButton: (UIButton) -> Void = { button in
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
        }
        
        initCircleButton(playPauseBtn)
        initCircleButton(lapResetBtn)
        
        lapsTable.delegate = self
        lapsTable.dataSource = self
        
        lapResetBtn.isEnabled = false
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "lapsCell", for: indexPath)
        
        if let labelNum = cell.viewWithTag(11) as? UILabel {
            labelNum.text = "Lap \(laps.count - (indexPath as NSIndexPath).row)"
        }
        
        if let labelTimer = cell.viewWithTag(12) as? UILabel {
            labelTimer.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
        }
        
        return cell
    }
    
    // 화면 회전 처리
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    // 상단 표시 줄
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
}

