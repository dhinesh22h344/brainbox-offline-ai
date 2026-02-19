//
//  ChatStorage.swift
//  OfflineCursorBrain
//
//  Persists chat history locally (UserDefaults). Fully offline.
//

import Foundation

final class ChatStorage: ObservableObject {
    private let key = "offline_cursor_brain_messages"
    
    @Published private(set) var messages: [ChatMessage] = []
    
    init() {
        load()
    }
    
    func add(_ message: ChatMessage) {
        messages.append(message)
        save()
    }
    
    func clear() {
        messages = []
        save()
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([ChatMessage].self, from: data) else {
            return
        }
        messages = decoded
    }
    
    private func save() {
        guard let data = try? JSONEncoder().encode(messages) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
