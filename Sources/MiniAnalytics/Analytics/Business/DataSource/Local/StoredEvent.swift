//
//  StoredEvent.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation
import SwiftData

@Model
final class StoredEvent {
    var id: String
    var name: String
    var properties: [String: String]
    var timestamp: String
    var isSent: Bool
    
    init(from dto: AnalyticsEventDTO) {
        self.id = dto.id
        self.name = dto.name
        self.properties = dto.properties
        self.timestamp = dto.timestamp
        self.isSent = false
    }
    
    func toDTO() -> AnalyticsEventDTO {
        AnalyticsEventDTO(id: id, name: name, properties: properties, timestamp: timestamp)
    }
}
