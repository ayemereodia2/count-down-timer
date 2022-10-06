//
//  CountDownClock.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/10/06.
//

import Foundation
protocol CountDownTimerDelegate: AnyObject {
    func show(_ counter: String)
}

class CountDownTimer {
    
    weak var delegate: CountDownTimerDelegate?
    private var hours: Int
    private var minutes: Int
    private var seconds: Int
    
    init (hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
   lazy var timer: Timer? = {
       let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                        target: self,
                                        selector: #selector(updateCounter),
                                        userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        return timer
    }()
    
    @objc func updateCounter() {
        if minutes == 60 {
            if hours > 0 {
                hours -= 1
                minutes -= 1
            }
        }
        
        if minutes == 0 {
            if hours > 0 {
                hours -= 1
                minutes = 60
            }
        }
        
        if seconds == 0 {
            minutes -= 1
            seconds = 60
        }
        
        if seconds != 0 {
            seconds -= 1
        }
        
        delegate?.show("\(hours):\(minutes):\(seconds)")
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
}
