//
//  HTTPDispatcherProtocol.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

protocol HTTPDispatcherProtocol: Sendable {
    func dispatch(_ request: URLRequest) async throws
}
