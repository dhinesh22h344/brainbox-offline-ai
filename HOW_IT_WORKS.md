# How Offline Cursor Brain Works

## Flow (step by step)

```
You open the app
       ↓
OfflineCursorBrainApp.swift  →  shows ChatView
       ↓
ChatView
  • ChatStorage (ObservableObject) loads saved messages from UserDefaults
  • You type in the text field and tap send
       ↓
sendMessage()
  • Adds your message to storage (and saves to UserDefaults)
  • Sets isThinking = true (shows "..." bubble)
  • Calls LocalBrainService.respond(to: yourText) in a Task (async)
       ↓
LocalBrainService.respond(to:)
  • Trims and lowercases your text
  • Checks in order: empty → greeting → help → tech keywords (swift/ios/xcode) → cursor/offline/brain → default
  • Returns one string (no network, no API)
       ↓
Back on main thread: isThinking = false, appends reply to storage
  • Storage saves again to UserDefaults
  • UI updates (new bubble, scroll to bottom)
```

## Main pieces

| Part | Role |
|------|------|
| **OfflineCursorBrainApp** | Entry point; shows `ChatView`. |
| **ChatView** | UI: message list, input bar, clear button. Calls `LocalBrainService` and `ChatStorage`. |
| **ChatStorage** | Keeps `messages` in memory; loads/saves to UserDefaults key `offline_cursor_brain_messages`. |
| **LocalBrainService** | Pure logic: given a string, returns a reply (greetings, help, tech tips, or default). |
| **ChatMessage** | Model: id, content, isFromUser, createdAt. Codable for persistence. |

## Data flow

- **Input:** You type → `inputText` → on send, a `ChatMessage(isFromUser: true)` is added.
- **Brain:** `LocalBrainService.respond(to: content)` runs async, returns a string.
- **Output:** That string becomes a `ChatMessage(isFromUser: false)`; both are in `storage.messages` and persisted.
- **Persistence:** `ChatStorage` encodes/decodes `[ChatMessage]` to JSON and stores in UserDefaults.

No network is used anywhere; everything runs and is stored on the device.
