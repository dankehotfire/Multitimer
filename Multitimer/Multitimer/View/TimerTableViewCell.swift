//
//  TimerTableViewCell.swift
//  Multitimer
//
//  Created by Danil Nurgaliev on 09.07.2021.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    static let identifier = "TimerTableViewCell"

    var timer: TimerModel? {
      didSet {
        timerNameLabel.text = timer?.name
        setState()
        updateTime()
      }
    }
    
    var timerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer 1"
        label.textColor = .black
        return label
    }()
    
    var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemGray6
        contentView.addSubview(timerNameLabel)
        contentView.addSubview(timerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        timerNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        timerNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        timerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }

    func updateTime() {
        guard let timer = timer else {
            return
        }

        if timer.time != 0 {
            timer.time -= 1
            timerLabel.text = "\(timer.hours):\(timer.minutesString):\(timer.secondsString)"
        }
    }

    func setState() {
        guard let timer = timer else {
            return
        }
        
        timerNameLabel.attributedText = NSAttributedString(string: timer.name,
          attributes: nil)
    }
}
