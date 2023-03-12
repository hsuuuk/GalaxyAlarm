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
    
    static func zeroSecond() -> Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        dateComponents.second = 0
        let date = calendar.date(from: dateComponents)
        return date!
    }
}
