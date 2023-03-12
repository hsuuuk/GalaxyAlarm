//
//  Notification.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/10.
//

import UIKit
import UserNotifications
import AVFoundation

class UserNotification {
    
    static let shared = UserNotification()
    
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    func requset(alarm: AlarmData) {
        content.title = "알람"
        content.body = "알람 내용"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("original.wav"))
        
        let calender = Calendar.current
        let hour = calender.component(.hour, from: alarm.date)
        let minute = calender.component(.minute, from: alarm.date)
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        if alarm.selectDays.isEmpty {
            triggerRequest(dateMatching: dateComponents, repeats: false)
        } else {
            let weekday = alarm.selectDays.map({ $0.dateComponentWeekday })
            weekday.forEach { weekday in
                dateComponents.weekday = weekday
                triggerRequest(dateMatching: dateComponents, repeats: true)
            }
        }
    }
    
    func triggerRequest(dateMatching: DateComponents, repeats: Bool) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: repeats)
        let request = UNNotificationRequest(identifier: "알림 ID", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print("알림 등록 실패: \(error.localizedDescription)")
            } else {
                //print("알림 등록 성공")
            }
        }
    }
} 
