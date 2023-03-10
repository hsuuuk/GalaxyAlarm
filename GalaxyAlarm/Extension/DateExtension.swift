//
//  DateExtension.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/10.
//

import UIKit

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
