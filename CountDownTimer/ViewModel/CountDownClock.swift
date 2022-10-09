//
//  CountDownClock.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/10/06.
//

import Foundation
protocol CountDownTimerDelegate: AnyObject {
    func show(counter: String)
    func showPeriod(days: Int, weeks: Int)
}

class CountDownTimer {
    private var hours: Int = 0
    private var minutes: Int = 0
    private var seconds: Int = 0
    private var weeks: Int = 0
    private var days: Int = 0
    weak var delegate: CountDownTimerDelegate?
    private var event: FutureEvent

    init (event: FutureEvent) {
        self.event = event
    }
    
    func startTimer() {
        RunLoop.current.add(timer, forMode: .common)
        dateComponent(from: self.event)
    }
    
    private func dateComponent(from event: FutureEvent) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .init(secondsFromGMT: 1)!
        let breakdown = calendar.numberOfDaysBetween(Date.now, and: event.dateTime)
        if let days = breakdown.day {
            self.weeks = days / 7
            self.days = days % 7
            delegate?.showPeriod(days: self.days, weeks: self.weeks)
        }
        
        self.hours = 12
        self.minutes =  60
        self.seconds =  60
    }
    
   lazy var timer: Timer = {
       let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                        target: self,
                                        selector: #selector(updateCounter),
                                        userInfo: nil, repeats: true)
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
        
        delegate?.show(counter: "\(hours):\(minutes):\(seconds)")
    }
    
    deinit {
//        timer?.invalidate()
//        timer = nil
    }
}


extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> DateComponents {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day, .hour, .minute, .second], from: fromDate, to: toDate)
        
        return numberOfDays
    }
}
