//
//  AddAlarmController.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit

class AddAlarmController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .systemGray
        
        navigationItem.title = "알람 추가"
        
        let rightBarButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonTapped))
        leftBarButton.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButton
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.date = Date()
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            //make.height.equalTo(200)
        }
        
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(-10)
            make.left.bottom.right.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TFCell.self, forCellReuseIdentifier: "tfcell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
    }
    
    @objc func handleDatePicker() {
        
    }
    
    @objc func rightBarButtonTapped() {
        
    }
    
    @objc func leftBarButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
}

extension AddAlarmController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tfcell", for: indexPath) as! TFCell
            cell.backgroundColor = .systemGray6
            return cell
        } else {
            var cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.backgroundColor = .systemGray6
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "반복"
                cell.detailTextLabel?.text = "없음"
                cell.accessoryType = .disclosureIndicator
            case 2:
                cell.textLabel?.text = "사운드"
                cell.detailTextLabel?.text = "녹차"
                cell.accessoryType = .disclosureIndicator
            case 3:
                cell.textLabel?.text = "다시 알림"
                let switchButton = UISwitch()
                cell.accessoryView = switchButton
            default:
                cell.textLabel?.text = "공휴일엔 알람 끄기"
                let switchButton = UISwitch()
                cell.accessoryView = switchButton
                if switchButton.isOn {
                    print("on")
                } else {
                    print("off")
                }
            }
            return cell
        }
    }
}

extension AddAlarmController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let controller = RepeatController()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
