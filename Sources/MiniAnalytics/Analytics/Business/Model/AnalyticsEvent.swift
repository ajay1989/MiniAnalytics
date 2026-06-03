//
//  AnalyticsEvent.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

public struct AnalyticsEvent: Sendable, Identifiable {
    public let id: UUID
    public let name: String
    public let properties: [String: String]
    public let timestamp: Date
    
    public init(name: String, properties: [String: String] = [:]) {
        self.id = UUID()
        self.name = name
        self.properties = properties
        self.timestamp = Date()
    }
}
