//
//  NetworkManager.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/13.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var holidayList = [Item]()
    
    func request(completion: @escaping (() -> ())) {
        let year = Date.dateComponentYear()
        let url = "https://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?solYear=\(year)&ServiceKey=W20dZ%2FzPRBLwO%2BOF9sBZ2CR9mMv6v6jiGm5dLqsyGBo%2BUA8My0qhvu%2BKDUVx4C0FUrERFo2IdDq75ECcQW%2Bdfw%3D%3D&_type=json&numOfRows=100"
        
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: error calling GET")
                print(error)
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(JSONData.self, from: data)
                self.holidayList = data.response.body.items.item
                completion()
            } catch {
                print(error.localizedDescription)
                print("DEBUG: fail")
            }
        }.resume()
    }
}
