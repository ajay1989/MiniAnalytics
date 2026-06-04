//
//  RetryPolicy.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

struct RetryPolicy {
    let maxAttempts: Int
    let baseDelay: TimeInterval
    
    static let `default` = RetryPolicy(maxAttempts: 3, baseDelay: 2.0)
    
    func execute(_ operation: @Sendable () async throws -> Void) async throws {
        var attempt = 0
        while attempt < maxAttempts {
            do {
                try await operation()
                return
            } catch {
                attempt += 1
                if attempt >= maxAttempts { throw error }
                let delay = baseDelay * pow(2.0, Double(attempt - 1))
                try await Task.sleep(for: .seconds(delay))
            }
        }
    }
}
