import Testing
@testable import MiniAnalytics

@Suite("AnalyticsService Tests")
struct AnalyticsServiceTests {

    @Test("track saves event to repository")
    func trackSavesEvent() async throws {
        let mockRepo = MockEventRepository()
        let service = AnalyticsService(repository: mockRepo)

        let event = AnalyticsEvent(name: "button_tapped", properties: ["screen": "home"])
        try await service.track(event)

        let saved = await mockRepo.savedEvents
        #expect(saved.count == 1)
        #expect(saved.first?.name == "button_tapped")
    }

    @Test("track calls flush after saving")
    func trackCallsFlush() async throws {
        let mockRepo = MockEventRepository()
        let service = AnalyticsService(repository: mockRepo)

        try await service.track(AnalyticsEvent(name: "app_opened"))

        let flushCount = await mockRepo.flushCallCount
        #expect(flushCount == 1)
    }

    @Test("track does not throw when flush fails")
    func trackDoesNotThrowWhenFlushFails() async throws {
        let mockRepo = MockEventRepository()
        await mockRepo.setThrowOnFlush(true)
        let service = AnalyticsService(repository: mockRepo)

        // Should not throw — flush failure is silent
        try await service.track(AnalyticsEvent(name: "test_event"))

        let saved = await mockRepo.savedEvents
        #expect(saved.count == 1)
    }

    @Test("flush retries on failure")
    func flushRetriesOnFailure() async throws {
        let mockRepo = MockEventRepository()
        await mockRepo.setThrowOnFlush(true)
        let retryPolicy = RetryPolicy(maxAttempts: 2, baseDelay: 0.01)
        let service = AnalyticsService(repository: mockRepo, retryPolicy: retryPolicy)

        await #expect(throws: MockError.self) {
            try await service.flush()
        }
    }
}
