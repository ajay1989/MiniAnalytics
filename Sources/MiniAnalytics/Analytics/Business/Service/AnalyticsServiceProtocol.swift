//
//  AnalyticsServiceProtocol.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

public protocol AnalyticsServiceProtocol: Sendable {
    func track(_ event: AnalyticsEvent) async throws
    func flush() async throws
}
