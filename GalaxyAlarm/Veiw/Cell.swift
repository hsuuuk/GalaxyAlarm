//
//  Cell.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit
import SnapKit

class Cell: UITableViewCell {
    
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
    
    var dayLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.text = "알람, 매일"
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(middayLabel)
        middayLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(24)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(middayLabel.snp.right)
            make.top.equalToSuperview().offset(5)
        }
        
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(middayLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }
    }
}

