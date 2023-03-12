//
//  Cell.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit
import SnapKit

class MainCell: UITableViewCell {
    
    var middayLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 35)
        return lb
    }()
    
    var timeLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 55, weight: .light)
        return lb
    }()
    
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    var repeatDayLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    var callBackSwitchState: (() -> ())?
    
    let onoffSwitch: UISwitch = {
        let sw = UISwitch(frame: .zero)
        sw.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        sw.isOn = true
        return sw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func switchChanged() {
        callBackSwitchState?()
    }
    
    func configure() {
        contentView.addSubview(middayLabel)
        middayLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(24)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(middayLabel.snp.right)
            make.top.equalToSuperview().offset(5)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(middayLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }
        
        contentView.addSubview(repeatDayLabel)
        repeatDayLabel.snp.makeConstraints { make in
            make.top.equalTo(middayLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel.snp.right)
        }
        
        self.accessoryView = onoffSwitch
    }
}


