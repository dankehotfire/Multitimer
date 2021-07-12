//
//  TimerManager.swift
//  Multitimer
//
//  Created by Danil Nurgaliev on 10.07.2021.
//

import Foundation

class TimerManager {
    var timersArray = [TimerModel]()

    func addTimer(name: String, time: Int) {
        let newTimer = TimerModel(name: name, time: time)
        timersArray.insert(newTimer, at: 0)
        timersArray.sort { $0.time > $1.time }
    }

    func removeTimer(at index: Int) {
        timersArray.remove(at: index)
    }
}
