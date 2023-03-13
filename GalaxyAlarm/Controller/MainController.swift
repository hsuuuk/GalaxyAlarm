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
    
    var dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        tableView.register(MainCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        
        navigationItem.title = "알람"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        rightBarButton.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = rightBarButton
        
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = .systemOrange
        editButtonItem.title = "편집"
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        editButtonItem.title = editing ? "완료" : "편집"
        tableView.setEditing(editing, animated: true)
    }
    
    @objc func rightBarButtonTapped() {
        let controller = AddAlarmController()
        controller.delegate = self
        dataManager.isEdit = false
        navigationController?.present(UINavigationController(rootViewController: controller), animated: true)
    }
}

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
        cell.middayLabel.text = dataManager.alarmList[indexPath.row].date.toString(format: "a")
        cell.timeLabel.text = dataManager.alarmList[indexPath.row].date.toString(format: "h:mm")
        cell.titleLabel.text = dataManager.alarmList[indexPath.row].title
        if dataManager.alarmList[indexPath.row].selectDays.isEmpty {
            cell.repeatDayLabel.text = ""
        } else {
            cell.repeatDayLabel.text = (", \(dataManager.alarmList[indexPath.row].repeatDay)")
        }
        cell.onoffSwitch.isOn = dataManager.alarmList[indexPath.row].isOn
        cell.callBackSwitchState = {
            self.dataManager.alarmList[indexPath.row].isOn.toggle()
        }
        cell.editingAccessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (_, _, success: @escaping (Bool) -> Void) in
            self.dataManager.remove(index: indexPath.row)
            self.tableView.reloadData()
            success(true)
        }
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contrller = AddAlarmController()
        contrller.alarmData = dataManager.alarmList[indexPath.row]
        contrller.datePicker.date = dataManager.alarmList[indexPath.row].date
        contrller.delegate = self
        contrller.indexPathRow = indexPath.row
        dataManager.isEdit = true
        navigationController?.present(UINavigationController(rootViewController: contrller), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainController: AddAlarmControllerDelegate {
    func save(alarmData: AlarmData, index: Int) {
        if dataManager.isEdit == false {
            dataManager.add(alarmData: alarmData)
        } else {
            dataManager.edit(alarmData: alarmData, index: index)
        }
        tableView.reloadData()
    }
}

extension MainController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("알람 실행")
    }
}
