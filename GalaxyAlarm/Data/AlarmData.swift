//
//  AlarmData.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit
import UserNotifications

struct AlarmData {
    var date = Date()
    var selectDays: Set<WeekDay> = []
    var title: String = ""
    //    var sound: String
    //    var snoozeTime: Int
    
    var isOn = true {
        didSet {
            if isOn {
                UserNotification.shared.requset(alarm: self)
            } else {
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
        }
    }
    
    var repeatDay: String {
        switch selectDays {
        case [.Sat, .Sun]:
            return "주말"
        case [.Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat]:
            return "매일"
        case [.Mon, .Tue, .Wed, .Thu, .Fri]:
            return "주중"
        case []:
            return "안함"
        default:
            let day = selectDays.sorted(by: { $0.rawValue < $1.rawValue }).map{ $0.dayText }.joined(separator: " ")
            return day
        }
    }
}

