//
//  ViewController.swift
//  StopWatch
//
//  Created by 이다영 on 2021/03/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var laps: [String] = []
    private let mainStopwatch: Time = Time()
    private let lapStopwatch: Time = Time()
    private var isPlay: Bool = false
    
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
    
    private func changeButton(_ button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    private func resetTimer(_ time: Time, label: UILabel) {
        time.timer.invalidate()
        time.counter = 0.0
        label.text = "00:00.00"
    }
    
    private func resetMainTimer() {
        resetTimer(mainStopwatch, label: timer)
        laps.removeAll()
        lapsTable.reloadData()
    }
    
    private func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimer)
    }
    
    func updateTimer(_ time: Time, label: UILabel) {
        time.counter = time.counter + 0.035
        
        var minutes: String = "\((Int)(time.counter / 60))"
        
        if (Int)(time.counter / 60) < 10 {
            minutes = "0\((Int)(time.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (time.counter.truncatingRemainder(dividingBy: 60)))
        
        if time.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        label.text = minutes + ":" + seconds
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopwatch, label: timer)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimer)
    }
    
    @IBAction func playPauseTimer(_ sender: AnyObject) {
        lapResetBtn.isEnabled = true
        changeButton(lapResetBtn, title: "Lap", titleColor: UIColor.black)
        
        if !isPlay {
            unowned let weakSelf = self
            
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            
            RunLoop.current.add(mainStopwatch.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
            
            isPlay = true
            
            changeButton(playPauseBtn, title: "Stop", titleColor: UIColor.red)
        } else {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(playPauseBtn, title: "Start", titleColor: UIColor.green)
            changeButton(lapResetBtn, title: "Reset", titleColor: UIColor.black)
        }
    }
}

private extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}
