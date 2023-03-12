//
//  RepeatController.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/06.
//

import UIKit

protocol RepeatControllerDelegate: AnyObject {
    func updateWeekday(selectedDay: Set<WeekDay>)
}

class RepeatController: UIViewController {
    
    var selectedDay: Set<WeekDay> = []
    
    weak var delegate: RepeatControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.updateWeekday(selectedDay: selectedDay)
    }
    
    func configure() {
        view.backgroundColor = .systemGroupedBackground
        
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
        return WeekDay.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        let day = WeekDay.allCases[indexPath.row]
        cell.textLabel?.text = day.dayString
        let isSelected = selectedDay.contains(day)
        cell.accessoryType = isSelected ? .checkmark : .none
        cell.tintColor = .systemOrange
        return cell
    }
}

extension RepeatController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = WeekDay.allCases[indexPath.row]
        if selectedDay.contains(day) {
            selectedDay.remove(day)
        } else {
            selectedDay.update(with: day)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
    

