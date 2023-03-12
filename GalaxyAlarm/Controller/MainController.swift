//
//  MainController.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit
import SnapKit
import UserNotifications

class MainController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var alarmList: [AlarmData] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        tableView.register(MainCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        
        navigationItem.title = "알람"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func rightBarButtonTapped() {
        let controller = AddAlarmController()
        controller.delegate = self
        navigationController?.present(UINavigationController(rootViewController: controller), animated: true)
    }
}

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
        cell.middayLabel.text = alarmList[indexPath.row].date.toString(format: "a")
        cell.timeLabel.text = alarmList[indexPath.row].date.toString(format: "h:mm")
        
//        var titleText = ""
//        if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! AddTitleCell
//            if let text = cell.titleTextField.text {
//                titleText = text
//            }
//            return cell
//        }
//        cell.titleLabel.text = titleText
        
        if alarmList[indexPath.row].selectDays.isEmpty {
            cell.repeatDayLabel.text = ""
        } else {
            cell.repeatDayLabel.text = (", \(alarmList[indexPath.row].repeatDay)")
        }
        cell.onoffSwitch.isOn = alarmList[indexPath.row].isOn
        cell.callBackSwitchState = {
            self.alarmList[indexPath.row].isOn.toggle()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (_, _, success: @escaping (Bool) -> Void) in
            self.alarmList.remove(at: indexPath.row)
            self.tableView.reloadData()
            success(true)
        }
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension MainController: UITableViewDelegate {
    
}

extension MainController: AddAlarmControllerDelegate {
    func saveAlarmInfo(alarmData: AlarmData) {
        alarmList.append(alarmData)
    }
}

extension MainController {
    func setUserNoti() {
        
    }
}

