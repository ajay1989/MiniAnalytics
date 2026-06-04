//
//  EventRepository.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

actor EventRepository: EventRepositoryProtocol {
    private let remote: RemoteDataSourceProtocol
    private let local: LocalDataSourceProtocol
    
    init(remote: RemoteDataSourceProtocol, local: LocalDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }
    
    func save(_ event: AnalyticsEvent) async throws {
        let dto = AnalyticsEventDTO(from: event)
        try await local.save(dto)
    }
    
    func flush() async throws {
        let pending = try await local.fetchPending()
        guard !pending.isEmpty else { return }
        try await remote.send(pending)
        let ids = pending.compactMap { UUID(uuidString: $0.id) }
        try await local.markAsSent(ids)
    }
}
