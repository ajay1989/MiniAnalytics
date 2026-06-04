//
//  LRUCache.swift
//  MiniAnalytics
//
//  Created by Ajay Vyas on 04/06/26.
//

import Foundation

final class LRUCache<Key: Hashable, Value> {
    private let capacity: Int
    private var cache: [Key: Value] = [:]
    private var order: [Key] = []
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Key) -> Value? {
        guard let value = cache[key] else { return nil }
        moveToFront(key)
        return value
    }
    
    func set(_ key: Key, value: Value) {
        if cache[key] != nil {
            moveToFront(key)
        } else {
            if order.count >= capacity, let last = order.last {
                order.removeLast()
                cache.removeValue(forKey: last)
            }
            order.insert(key, at: 0)
        }
        cache[key] = value
    }
    
    private func moveToFront(_ key: Key) {
        order.removeAll { $0 == key }
        order.insert(key, at: 0)
    }
}
