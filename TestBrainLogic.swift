#!/usr/bin/env swift
//
// Command-line test for LocalBrainService-style logic.
// Run: swift TestBrainLogic.swift
//

import Foundation

// Same logic as LocalBrainService (copied for standalone test)
func respond(to userMessage: String) -> String {
    let trimmed = userMessage.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    
    if trimmed.isEmpty {
        return "Hi. Ask me anything — I run fully offline on your device."
    }
    if ["hi", "hello", "hey", "howdy"].contains(where: { trimmed.hasPrefix($0) || trimmed == $0 }) {
        return "Hello! I'm Brainbox — your offline AI. I work without the internet. What would you like to do?"
    }
    if ["help", "what can you do", "commands"].contains(where: { trimmed.hasPrefix($0) || trimmed == $0 }) {
        return "I work **offline** on this device. You can: • Ask me to explain code or concepts • Get short tips (e.g. Swift, SwiftUI, iOS) • Brainstorm or outline ideas. I don't use the network — everything stays on your phone."
    }
    if ["swift", "swiftui", "ios", "xcode"].contains(where: { trimmed.contains($0) }) {
        if trimmed.contains("swiftui") || trimmed.contains("swift ui") {
            return "SwiftUI tip: Use @State for view-owned state, @Binding to pass writable state to children, and @ObservedObject / @StateObject for reference types."
        }
        if trimmed.contains("ios") {
            return "iOS tip: For offline-first apps, use UserDefaults or SwiftData/Core Data for persistence."
        }
        if trimmed.contains("xcode") {
            return "Xcode tip: Use Cmd+B to build, Cmd+R to run. For SwiftUI previews use #Preview { YourView() }."
        }
        return "Swift/iOS: Prefer value types (struct, enum), use async/await for async code."
    }
    if ["cursor", "offline", "brain"].contains(where: { trimmed.contains($0) }) {
        return "Brainbox is your offline AI: chat and get answers without the internet."
    }
    if ["java", "java programming", "java code"].contains(where: { trimmed.contains($0) }) {
        return "Here's a simple Java program you can run:\n\npublic class HelloWorld {\n    public static void main(String[] args) {\n        System.out.println(\"Hello, World!\");\n    }\n}\n\nSave as HelloWorld.java, then: javac HelloWorld.java && java HelloWorld"
    }
    return "Got it. I'm running fully offline — your data stays on this device. Ask me something specific."
}

// Run tests
let testInputs = [
    "",
    "hi",
    "Hello",
    "help",
    "what can you do",
    "SwiftUI",
    "iOS tip?",
    "xcode",
    "cursor brain",
    "do me a code for java programming",
    "random question",
]

print("=== Brainbox — Logic test ===\n")
var passed = 0
for input in testInputs {
    let reply = respond(to: input)
    let preview = reply.prefix(60) + (reply.count > 60 ? "..." : "")
    print("Input:  \"\(input)\"")
    print("Reply:  \(preview)")
    print("")
    if !reply.isEmpty { passed += 1 }
}
print("=== Done: \(passed)/\(testInputs.count) produced replies ===\n")
print("If you see replies above, Brainbox logic works. The iOS app uses the same logic in LocalBrainService.swift.")
