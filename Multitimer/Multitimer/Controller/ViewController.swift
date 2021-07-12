//
//  ViewController.swift
//  Multitimer
//
//  Created by Danil Nurgaliev on 09.07.2021.
//

import UIKit

class ViewController: UIViewController {
    private var timerManager = TimerManager()
    private var headerView = HeaderView()
    private var timer: Timer?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TimerTableViewCell.self,
                           forCellReuseIdentifier: TimerTableViewCell.identifier)
        return tableView
    }()

    override func loadView() {
        super.loadView()
        headerView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height / 2)
        tableView.frame = CGRect(x: view.frame.origin.x, y: view.frame.height / 2, width: view.frame.width, height: view.frame.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemGray6

        navigationController?.navigationBar.topItem?.title = "Multi timer"

        tableView.dataSource = self
        tableView.delegate = self
        headerView.delegate = self

        view.addSubview(tableView)
        view.addSubview(headerView)
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 0, width: view.frame.width, height: 20)
        myLabel.font = UIFont.systemFont(ofSize: 12)
        myLabel.textColor = .gray
        myLabel.backgroundColor = .systemGray6
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Таймеры"
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - UITableViewDataSourcer
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimerTableViewCell.identifier, for: indexPath) as? TimerTableViewCell else {
            return UITableViewCell()
        }
        cell.timer = timerManager.timersArray[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerManager.timersArray.count
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            timerManager.removeTimer(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Delegate Methods
extension ViewController: HeaderViewDelegate {
    func showAlert() {
        showAlert(alertTitle: "Ошибка", alertMessage: "Пожалуйста, введите корректные данные", defaultButtonTitle: "Ok")
    }

    func fillCellWith(name: String, time: Int) {
        timerManager.addTimer(name: name, time: time)
        createTimer()
        tableView.reloadData()
    }
}

// MARK: - Timer
extension ViewController {
    @objc func updateTimer() {
        guard let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows else {
            return
        }

        for indexPath in visibleRowsIndexPaths {
            if let cell = tableView.cellForRow(at: indexPath) as? TimerTableViewCell {
                cell.updateTime()

                if cell.timer?.time == 0 {
                    timerManager.removeTimer(at: indexPath.row)
                    tableView.reloadData()
                }
            }
        }
    }

    func createTimer() {
        if timer == nil {
            let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1

            self.timer = timer
        }
    }
}
