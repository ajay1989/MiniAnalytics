//
//  LocalDataSourceProtocol.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

protocol LocalDataSourceProtocol: Sendable {
    func save(_ dto: AnalyticsEventDTO) async throws
    func fetchPending() async throws -> [AnalyticsEventDTO]
    func markAsSent(_ ids: [UUID]) async throws
}
