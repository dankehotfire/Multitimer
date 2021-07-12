//
//  TimerModel.swift
//  Multitimer
//
//  Created by Danil Nurgaliev on 09.07.2021.
//

import Foundation

class TimerModel {
    let name: String
    var time: Int
    var isStoped = false

    var hours: Int {
        return time / 3600
    }
    var minutes: Int {
        return (time % 3600) / 60
    }
    var seconds: Int {
        return (time % 3600) % 60
    }

    var minutesString: String {
        if minutes < 10 {
            return "0\(minutes)"
        }
        return "\(minutes)"
    }

    var secondsString: String {
        if seconds < 10 {
            return "0\(seconds)"
        }
        return "\(seconds)"
    }

    init(name: String, time: Int) {
        self.name = name
        self.time = time
    }
}
