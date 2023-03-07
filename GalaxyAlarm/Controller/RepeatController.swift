//
//  RepeatController.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/06.
//

import UIKit

class RepeatController: UIViewController {
    
    let day = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .systemGray
        
        navigationItem.title = "반복"
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.topItem?.title = "뒤로"
        
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
    }
}

extension RepeatController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.backgroundColor = .systemGray6
        cell.textLabel?.text = day[indexPath.row]
        return cell
    }
}

extension RepeatController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AddAlarmController()
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.tintColor = .systemOrange
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                guard let day = cell.textLabel?.text else { return }
                if !controller.alarmData.day.contains(day) {
                    controller.alarmData.day.append(day)
                    print(controller.alarmData.day)
                }
            } else {
                cell.accessoryType = .none
                guard let day = cell.textLabel?.text else { return }
                if controller.alarmData.day.contains(day), let index = controller.alarmData.day.firstIndex(of: day) {
                    controller.alarmData.day.remove(at: index)
                    print(controller.alarmData.day)
                }
            }
        }
    }
}
    
