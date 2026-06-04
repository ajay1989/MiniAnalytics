//
//  AnalyticsService.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

public actor AnalyticsService: AnalyticsServiceProtocol {
    private let repository: EventRepositoryProtocol
    
    init(repository: EventRepositoryProtocol) {
        self.repository = repository
    }
    
    public static func create(endpointURL: URL) throws -> AnalyticsService {
        let dispatcher = HTTPDispatcher()
        let local = try EventLocalDataSource()
        let remote = EventRemoteDataSource(dispatcher: dispatcher, endpointURL: endpointURL)
        let repository = EventRepository(remote: remote, local: local)
        return AnalyticsService(repository: repository)
    }
    
    public func track(_ event: AnalyticsEvent) async throws {
        try await repository.save(event)
        try? await flush()
    }
    
    public func flush() async throws {
        try await repository.flush()
    }
}
