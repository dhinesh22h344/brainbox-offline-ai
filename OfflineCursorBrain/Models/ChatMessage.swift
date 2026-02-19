//
//  ChatMessage.swift
//  OfflineCursorBrain
//

import Foundation

struct ChatMessage: Identifiable, Codable, Equatable {
    let id: UUID
    let content: String
    let isFromUser: Bool
    let createdAt: Date

    init(id: UUID = UUID(), content: String, isFromUser: Bool, createdAt: Date = Date()) {
        self.id = id
        self.content = content
        self.isFromUser = isFromUser
        self.createdAt = createdAt
    }
}
