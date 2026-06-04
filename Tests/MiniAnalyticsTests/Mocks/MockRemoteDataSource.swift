import Foundation
@testable import MiniAnalytics

actor MockRemoteDataSource: RemoteDataSourceProtocol {
    private(set) var sentDTOs: [AnalyticsEventDTO] = []
    var shouldThrow: Bool = false

    func send(_ dtos: [AnalyticsEventDTO]) async throws {
        if shouldThrow { throw MockError.sendFailed }
        sentDTOs.append(contentsOf: dtos)
    }
}
