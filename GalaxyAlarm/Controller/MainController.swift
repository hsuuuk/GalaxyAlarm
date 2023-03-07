//
//  MainController.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit
import SnapKit

class MainController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let dataManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchData()
    }
    
    func fetchData() {
        dataManager.fetchAlarmList()
    }

    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
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
        return dataManager.alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.middayLabel.text = dataManager.alarmList[indexPath.row].midday
        cell.timeLabel.text = dataManager.alarmList[indexPath.row].time
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (_, _, success: @escaping (Bool) -> Void) in
            
            let deletedAlarm = self.dataManager.alarmList[indexPath.row]
            self.dataManager.deleteAlarm(data: deletedAlarm) {
                self.dataManager.fetchAlarmList()
                self.tableView.reloadData()
            }
            success(true)
        }
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension MainController: UITableViewDelegate {
    
}

extension MainController: AddAlarmControllerDelegate {
    func didAddAlarm() {
        dataManager.fetchAlarmList()
        tableView.reloadData()
    }
}

