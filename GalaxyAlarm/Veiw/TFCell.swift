//
//  TFCell.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/06.
//

import UIKit
import SnapKit

class TFCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "레이블"
        return lb
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .right
        tf.clearButtonMode = .whileEditing
        tf.placeholder = "알람"
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
}
