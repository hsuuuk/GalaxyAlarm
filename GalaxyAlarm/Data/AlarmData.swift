//
//  AlarmData.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit

struct AlarmData {
    var date: Date
//    var title: String
//    var sound: String
//    var isActive: Bool
//    var repeatDays: [Weekday]
//    var snoozeTime: Int
    
//    static func createTime(hour: Int, minute: Int) -> Date {
//        let currentDate = Date()
//        let calendar = Calendar.current
//        //let dateComponent = DateComponents
//        let dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
//
//        var newDateComponents = DateComponents()
//        newDateComponents.year = dateComponents.year
//        newDateComponents.month = dateComponents.month
//        newDateComponents.day = dateComponents.day
//        newDateComponents.hour = hour
//        newDateComponents.minute = minute
//
//        let newDate = calendar.date(from: newDateComponents)!
//        return newDate
//    }
}

enum Weekday: Int {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}
