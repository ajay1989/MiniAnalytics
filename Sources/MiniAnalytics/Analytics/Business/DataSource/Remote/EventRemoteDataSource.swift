//
//  EventRemoteDataSource.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

actor EventRemoteDataSource: RemoteDataSourceProtocol {
    private let dispatcher: HTTPDispatcherProtocol
    private let endpointURL: URL
    
    init(dispatcher: HTTPDispatcherProtocol, endpointURL: URL) {
        self.dispatcher = dispatcher
        self.endpointURL = endpointURL
    }
    
    func send(_ dtos: [AnalyticsEventDTO]) async throws {
        var request = URLRequest(url: endpointURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(dtos)
        try await dispatcher.dispatch(request)
    }
}
