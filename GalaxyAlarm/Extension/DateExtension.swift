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
    
    func toInt() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let string = formatter.string(from: Date())
        return Int(string)!
    }
    
    static func zeroSecond() -> Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        dateComponents.second = 0
        let date = calendar.date(from: dateComponents)
        return date!
    }
    
    static func dateComponentYear() -> Int {
        let calendar = Calendar.current
        let component = calendar.component(.year, from: Date())
        return component
    }
    
    static func nextDayDate(alarmDate: Date) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let calendar = Calendar.current
        
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        var date = calendar.date(from: dateComponents)
        let dateHourMinute = formatter.string(from: date!)
        
        var alarmDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: alarmDate)
        var alarmDate = calendar.date(from: alarmDateComponents)
        let alarmHourMinute = formatter.string(from: alarmDate!)

        if alarmHourMinute > dateHourMinute {
            alarmDateComponents.day = calendar.component(.day, from: Date()) + 1
            let date = calendar.date(from: alarmDateComponents)
            print("nextDayDate1: \(formatter.string(from: date!))")
            return date!
        } else {
            alarmDateComponents.day = calendar.component(.day, from: Date()) + 2
            let date = calendar.date(from: alarmDateComponents)
            print("nextDayDate2: \(formatter.string(from: date!))")
            return date!
        }
    }
}
