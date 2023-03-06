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
        lb.text = "오전"
        return lb
    }()
    
    var timeLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 55, weight: .light)
        lb.text = "7:20"
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
            make.centerY.equalToSuperview()
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(middayLabel.snp.right)
            make.centerY.equalToSuperview()
        }
    }
}

