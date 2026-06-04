//
//  AnalyticsEventDTO.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

struct AnalyticsEventDTO: Codable, Sendable {
    let id: String
    let name: String
    let properties: [String: String]
    let timestamp: String
    
    init(from event: AnalyticsEvent) {
        self.id = event.id.uuidString
        self.name = event.name
        self.properties = event.properties
        self.timestamp = ISO8601DateFormatter().string(from: event.timestamp)
    }
}
