//
//  RemoteDataSourceProtocol.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

protocol RemoteDataSourceProtocol: Sendable {
    func send(_ dtos: [AnalyticsEventDTO]) async throws
}
