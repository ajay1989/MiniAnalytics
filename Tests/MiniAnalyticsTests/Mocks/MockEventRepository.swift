import Foundation
@testable import MiniAnalytics

actor MockEventRepository: EventRepositoryProtocol {
    private(set) var savedEvents: [AnalyticsEvent] = []
    private(set) var flushCallCount: Int = 0
    var shouldThrowOnFlush: Bool = false

    func save(_ event: AnalyticsEvent) async throws {
        savedEvents.append(event)
    }

    func flush() async throws {
        if shouldThrowOnFlush { throw MockError.flushFailed }
        flushCallCount += 1
    }

    func setThrowOnFlush(_ value: Bool) {
        shouldThrowOnFlush = value
    }
}

enum MockError: Error {
    case flushFailed
    case sendFailed
}
