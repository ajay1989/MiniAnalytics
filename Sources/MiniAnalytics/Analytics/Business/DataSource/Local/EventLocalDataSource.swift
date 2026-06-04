//
//  EventLocalDataSource.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation
import SwiftData

actor EventLocalDataSource: LocalDataSourceProtocol {
    private let container: ModelContainer
    
    init() throws {
        self.container = try ModelContainer(for: StoredEvent.self)
    }
    
    func save(_ dto: AnalyticsEventDTO) async throws {
        let context = ModelContext(container)
        let stored = StoredEvent(from: dto)
        context.insert(stored)
        try context.save()
    }
    
    func fetchPending() async throws -> [AnalyticsEventDTO] {
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<StoredEvent>(
            predicate: #Predicate { !$0.isSent }
        )
        let results = try context.fetch(descriptor)
        return results.map { $0.toDTO() }
    }
    
    func markAsSent(_ ids: [UUID]) async throws {
        let context = ModelContext(container)
        let idStrings = ids.map { $0.uuidString }
        let descriptor = FetchDescriptor<StoredEvent>(
            predicate: #Predicate { idStrings.contains($0.id) }
        )
        let results = try context.fetch(descriptor)
        results.forEach { $0.isSent = true }
        try context.save()
    }
}
