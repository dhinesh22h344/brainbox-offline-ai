//
//  ChatView.swift
//  OfflineCursorBrain
//
//  Main chat UI — message list + input. Offline-only.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var storage = ChatStorage()
    @State private var inputText = ""
    @State private var isThinking = false
    @FocusState private var inputFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                messagesList
                inputBar
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Brainbox")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if !storage.messages.isEmpty {
                        Button("Clear") {
                            storage.clear()
                        }
                        .foregroundStyle(.orange)
                    }
                }
            }
        }
    }

    private var messagesList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    if storage.messages.isEmpty {
                        emptyState
                    }
                    ForEach(storage.messages) { message in
                        MessageBubble(message: message)
                            .id(message.id)
                    }
                    if isThinking {
                        ThinkingBubble()
                    }
                }
                .padding()
            }
            .onChange(of: storage.messages.count) { _ in
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: isThinking) { _ in
                scrollToBottom(proxy: proxy)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 56))
                .foregroundStyle(.secondary)
            Text("Brainbox")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Chat here. Everything runs on this device — no internet needed.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 48)
    }

    private var inputBar: some View {
        HStack(alignment: .bottom, spacing: 10) {
            TextField("Message...", text: $inputText, axis: .vertical)
                .textFieldStyle(.plain)
                .padding(12)
                .background(Color(uiColor: .secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .lineLimit(1...6)
                .focused($inputFocused)

            Button {
                sendMessage()
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .accentColor)
            }
            .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isThinking)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color(uiColor: .systemGroupedBackground))
    }

    private func sendMessage() {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        inputText = ""
        let userMessage = ChatMessage(content: text, isFromUser: true)
        storage.add(userMessage)
        isThinking = true
        inputFocused = false

        Task {
            let reply = await LocalBrainService.respond(to: text)
            await MainActor.run {
                isThinking = false
                storage.add(ChatMessage(content: reply, isFromUser: false))
            }
        }
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let last = storage.messages.last else { return }
        withAnimation(.easeOut(duration: 0.2)) {
            proxy.scrollTo(last.id, anchor: .bottom)
        }
    }
}

struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if message.isFromUser { Spacer(minLength: 48) }
            if !message.isFromUser {
                Image(systemName: "brain")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(message.content)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(message.isFromUser ? Color.accentColor : Color(uiColor: .secondarySystemGroupedBackground))
                .foregroundColor(message.isFromUser ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            if !message.isFromUser { Spacer(minLength: 48) }
            if message.isFromUser {
                Image(systemName: "person.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct ThinkingBubble: View {
    @State private var animating = false

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "brain")
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack(spacing: 4) {
                ForEach(0..<3) { i in
                    Circle()
                        .fill(Color.secondary)
                        .frame(width: 6, height: 6)
                        .scaleEffect(animating ? 1.2 : 0.8)
                        .animation(
                            .easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(Double(i) * 0.15),
                            value: animating
                        )
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            Spacer(minLength: 48)
        }
        .onAppear { animating = true }
    }
}

#Preview {
    ChatView()
}
