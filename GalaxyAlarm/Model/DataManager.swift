//
//  DataManager.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/13.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    private let alarmKey = "alarm"
    
    var isEdit = false
    
    var alarmList: [AlarmData] = [] {
        didSet {
            alarmList.sort { $0.date < $1.date }
            save()
        }
    }
    
    init() {
        fetch()
    }
    
    func add(alarmData: AlarmData) {
        alarmList.append(alarmData)
    }
    
    func edit(alarmData: AlarmData, index: Int) {
        alarmList[index] = alarmData
    }
    
    func remove(index: Int) {
        alarmList[index].isOn = false
        alarmList.remove(at: index)
    }
    
    func save() {
        guard let encoded = try? JSONEncoder().encode(alarmList) else { return }
        userDefaults.set(encoded, forKey: alarmKey)
    }
    
    func fetch(){
        guard let savedData = userDefaults.object(forKey: alarmKey) as? Data else { return }
        guard let fetchedData = try? JSONDecoder().decode([AlarmData].self, from: savedData) else { return }
        alarmList = fetchedData
    }
}
