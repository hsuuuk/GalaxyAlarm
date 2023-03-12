//
//  SoundController.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/06.
//

import UIKit

class SoundController: UIViewController {
    
    let bellSound = ["전파탐지기(기본 설정)", "공상음", "공지음", "녹차", "놀이시간", "느린 상승"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .systemGroupedBackground
        
        navigationItem.title = "사운드"
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.topItem?.title = "뒤로"
        
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
    }
}

extension SoundController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return bellSound.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        if indexPath.section == 0 {
            cell.textLabel?.text = "진동"
            cell.detailTextLabel?.text = "동기화됨"
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = bellSound[indexPath.row]
        }
        return cell
    }
}

extension SoundController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else {
            if let selectedCell = tableView.cellForRow(at: indexPath) {
                selectedCell.tintColor = .systemOrange
                if selectedCell.accessoryType == .checkmark {
                    selectedCell.accessoryType = .none
                } else {
                    selectedCell.accessoryType = .checkmark
                }
                
                for cell in tableView.visibleCells {
                    if cell != selectedCell {
                        cell.accessoryType = .none
                    }
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView(reuseIdentifier: "header")
        if section == 1 {
            header.textLabel?.text = "벨소리"
        }
        return header
    }
}


