//
//  Time.swift
//  StopWatch
//
//  Created by 이다영 on 2021/03/16.
//

import Foundation

class Time: NSObject {
    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
