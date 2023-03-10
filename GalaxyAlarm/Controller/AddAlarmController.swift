//
//  AddAlarmController.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit

protocol AddAlarmControllerDelegate: AnyObject {
    func didAddAlarm()
}

class AddAlarmController: UIViewController {
    
    var alarmData = AlarmData(time: "7:42", midday: "오전")
    let datePicker = UIDatePicker()
    weak var delegate: AddAlarmControllerDelegate?
    
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
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.date = Date()
        datePicker.timeZone = .autoupdatingCurrent
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(-25)
            make.left.bottom.right.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(AddCell.self, forCellReuseIdentifier: "AddCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
    }
    
    @objc func rightBarButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        let midday = formatter.string(from: datePicker.date)
        formatter.dateFormat = "h:mm"
        let timeString = formatter.string(from: datePicker.date)
        
        alarmData.midday = midday
        alarmData.time = timeString
        
        delegate?.didAddAlarm()
        navigationController?.dismiss(animated: true)
    }
    
    @objc func leftBarButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
}

extension AddAlarmController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddCell
            cell.backgroundColor = .systemGray6
            return cell
        } else {
            var cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.backgroundColor = .systemGray6
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "반복"
                cell.detailTextLabel?.text = "안 함"
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
            }
            return cell
        }
    }
}

extension AddAlarmController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            navigationController?.pushViewController(RepeatController(), animated: true)
        default :
            navigationController?.pushViewController(SoundController(), animated: true)
        }
    }
}
