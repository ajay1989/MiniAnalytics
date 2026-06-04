import Foundation
@testable import MiniAnalytics

actor MockLocalDataSource: LocalDataSourceProtocol {
    private(set) var savedDTOs: [AnalyticsEventDTO] = []
    private(set) var pendingDTOs: [AnalyticsEventDTO] = []
    private(set) var markedSentIDs: [UUID] = []

    func save(_ dto: AnalyticsEventDTO) async throws {
        savedDTOs.append(dto)
    }

    func fetchPending() async throws -> [AnalyticsEventDTO] {
        pendingDTOs
    }

    func markAsSent(_ ids: [UUID]) async throws {
        markedSentIDs.append(contentsOf: ids)
    }

    func addPending(_ dto: AnalyticsEventDTO) {
        pendingDTOs.append(dto)
    }
}
