//
//  EventRepositoryProtocol.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

protocol EventRepositoryProtocol: Sendable {
    func save(_ event: AnalyticsEvent) async throws
    func flush() async throws
}
