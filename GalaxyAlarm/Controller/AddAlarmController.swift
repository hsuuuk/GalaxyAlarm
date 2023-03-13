//
//  AddAlarmController.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit

protocol AddAlarmControllerDelegate: AnyObject {
    func save(alarmData: AlarmData, index: Int)
}

class AddAlarmController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var alarmData = AlarmData() {
        didSet { tableView.reloadData() }
    }
    
    weak var delegate: AddAlarmControllerDelegate?
    
    var indexPathRow = 0
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko-KR")
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        picker.timeZone = .autoupdatingCurrent
        picker.date = Date.zeroSecond()
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .systemGroupedBackground
        
        navigationItem.title = "알람 추가"
        
        let rightBarButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        rightBarButton.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonTapped))
        leftBarButton.tintColor = .systemOrange
        navigationItem.leftBarButtonItem = leftBarButton
        
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(-25)
            make.left.bottom.right.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(AddTitleCell.self, forCellReuseIdentifier: "AddCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
    }
    
    @objc func rightBarButtonTapped() {
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddTitleCell
        guard let text = cell.titleTextField.text else { return }
        if text == "" {
            alarmData.title = "알람"
        } else {
            alarmData.title = text
        }
        
        alarmData.date = datePicker.date
        print(alarmData)
        UserNotification.shared.requset(alarm: alarmData)
        delegate?.save(alarmData: alarmData, index: indexPathRow)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddTitleCell
            cell.titleLabel.text = "제목"
            cell.titleTextField.text = alarmData.title
            return cell
        } else {
            var cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "반복"
                cell.detailTextLabel?.text = alarmData.repeatDay
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
            let controller = RepeatController()
            controller.delegate = self
            controller.selectedDay = alarmData.selectDays
            navigationController?.pushViewController(controller, animated: true)
        default :
            navigationController?.pushViewController(SoundController(), animated: true)
        }
    }
}

extension AddAlarmController: RepeatControllerDelegate {
    func updateWeekday(selectedDay: Set<WeekDay>) {
        print(selectedDay)
        alarmData.selectDays = selectedDay
    }
}
