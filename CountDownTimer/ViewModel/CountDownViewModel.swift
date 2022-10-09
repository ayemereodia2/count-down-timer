//
//  CountDownViewModel.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/10/09.
//

import Foundation

protocol CountDownUpdaterDelegate: AnyObject {
    func updateCounter(with count: String)
    func updatePeriod(days: Int, and weeks: Int)
    func update(title: String?)
}

class CountDownViewModel {
    private let event: FutureEvent?
    private let countDownTimer: CountDownTimer
    weak var delegate: CountDownUpdaterDelegate?
    
    init(event: FutureEvent?, countDownTimer: CountDownTimer) {
        self.event = event
        self.countDownTimer = countDownTimer
        countDownTimer.delegate = self
    }
    
    func startCount() {
        countDownTimer.startTimer()
    }
    
    func updateEventTile() {
        delegate?.update(title: event?.name)
    }
}


extension CountDownViewModel: CountDownTimerDelegate {
    func show(counter: String) {
        delegate?.updateCounter(with: counter)
    }
    
    func showPeriod(days: Int, weeks: Int) {
        delegate?.updatePeriod(days: days, and: weeks)
    }
}
