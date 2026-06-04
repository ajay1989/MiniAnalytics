import Testing
@testable import MiniAnalytics

@Suite("EventRepository Tests")
struct EventRepositoryTests {

    @Test("save stores event locally as DTO")
    func savePersistsLocally() async throws {
        let mockLocal = MockLocalDataSource()
        let mockRemote = MockRemoteDataSource()
        let repo = EventRepository(remote: mockRemote, local: mockLocal)

        let event = AnalyticsEvent(name: "screen_viewed", properties: ["screen": "home"])
        try await repo.save(event)

        let saved = await mockLocal.savedDTOs
        #expect(saved.count == 1)
        #expect(saved.first?.name == "screen_viewed")
    }

    @Test("flush sends pending events to remote and marks them sent")
    func flushSendsPendingEvents() async throws {
        let mockLocal = MockLocalDataSource()
        let mockRemote = MockRemoteDataSource()
        let repo = EventRepository(remote: mockRemote, local: mockLocal)

        let dto = AnalyticsEventDTO(
            id: UUID().uuidString,
            name: "game_played",
            properties: [:],
            timestamp: "2026-06-04T00:00:00Z"
        )
        await mockLocal.addPending(dto)

        try await repo.flush()

        let sent = await mockRemote.sentDTOs
        let markedIDs = await mockLocal.markedSentIDs
        #expect(sent.count == 1)
        #expect(markedIDs.count == 1)
    }

    @Test("flush does nothing when no pending events")
    func flushSkipsWhenEmpty() async throws {
        let mockLocal = MockLocalDataSource()
        let mockRemote = MockRemoteDataSource()
        let repo = EventRepository(remote: mockRemote, local: mockLocal)

        try await repo.flush()

        let sent = await mockRemote.sentDTOs
        #expect(sent.isEmpty)
    }
}
