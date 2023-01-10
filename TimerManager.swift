//
//  TimerManager.swift
//  AajTakHD
//
//  Created by Nitin Kumar on 09/01/23.
//

import Foundation

class TimerManager {
    
    var timerCount = 0
    static let shared = TimerManager()
    var timer: Timer?
    var isPaused: Bool = true
    
    init() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        if timerCount < 30 {
            isPaused = false
            let minutes = String(timerCount / 60)
            let seconds = String(timerCount % 60)
            timerCount += 1
            debugPrint("timerCount_inProgress: ", timerCount, "\(minutes) min", "\(seconds) sec")
            
            guard let isValidTimer = timer?.isValid, !isValidTimer else { return }
            self.runTimer()
        } else {
            debugPrint("timerCount_invalidate_State: ", timerCount)
            self.stopTimer()
        }
    }
    
    func pauseTimer() {
        guard self.timer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        if isPaused == false {
            self.timer?.invalidate()
        }
    }
    
    func stopTimer() {
        guard self.timer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        self.isPaused = true
        self.timer?.invalidate()
        self.timer = nil
    }
    
    private func runTimer() {
        if timerCount < 30 {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        } else {
            debugPrint("timerCount_invalidate_State: ", timerCount)
            self.stopTimer()
        }
    }
}
