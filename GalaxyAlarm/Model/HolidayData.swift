//
//  API.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/13.
//

import Foundation

// MARK: - JSONData
struct JSONData: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let items: Items
}

// MARK: - Items
struct Items: Codable {
    let item: [Item]
}

// MARK: - Item
struct Item: Codable {
    let holidayDate: Int

    enum CodingKeys: String, CodingKey {
        case holidayDate = "locdate"
    }
}
