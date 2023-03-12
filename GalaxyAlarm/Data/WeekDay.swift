//
//  Day.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/12.
//

import Foundation

enum WeekDay: Int, CaseIterable, Codable {
    case Sun, Mon, Tue, Wed, Thu, Fri, Sat
    
    var dayString: String{
        switch self {
            case .Sun: return "일요일마다"
            case .Mon: return "월요일마다"
            case .Tue: return "화요일마다"
            case .Wed: return "수요일마다"
            case .Thu: return "목요일마다"
            case .Fri: return "금요일마다"
            case .Sat: return "토요일마다"
        }
    }
    
    var dayText: String{
        switch self {
            case .Sun: return "일"
            case .Mon: return "월"
            case .Tue: return "화"
            case .Wed: return "수"
            case .Thu: return "목"
            case .Fri: return "금"
            case .Sat: return "토"
        }
    }
    
    var dateComponentWeekday: Int {
        switch self {
            case .Sun: return 1
            case .Mon: return 2
            case .Tue: return 3
            case .Wed: return 4
            case .Thu: return 5
            case .Fri: return 6
            case .Sat: return 7
        }
    }
}
