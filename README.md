# 🧠 Brainbox

**Offline AI chat app — iOS (Swift/SwiftUI) & Android (Kotlin/Jetpack Compose)**  
No API keys. No network. Code examples and tips for 20+ languages and frameworks, all on-device.

---

## ✨ What it does

- **Chat UI** — Send messages and get instant replies, fully offline.
- **Local storage** — Conversation history saved on device (UserDefaults / SharedPreferences).
- **Offline “brain”** — Code snippets and tips for **Java, Python, JavaScript, TypeScript, Kotlin, Swift, SwiftUI, C++, C#, Go, Rust, PHP, Ruby**, and frameworks like **React, Angular, Vue, Django, Flask, Spring Boot, .NET, Node, Express**, plus **SQL, HTML, CSS**, and **iOS/Xcode**.

Perfect for learning on the go, in airplane mode, or where you want zero data leaving the device.

---

## 🛠 Tech stack

| Platform | Stack |
|----------|------|
| **iOS** | Swift, SwiftUI, UserDefaults |
| **Android** | Kotlin, Jetpack Compose, ViewModel, SharedPreferences |

---

## 🧪 Testing

The offline brain logic is tested with a small script (no Xcode/Android Studio needed):

```bash
swift TestBrainLogic.swift
```

**Expected:** `Done: 11/11 produced replies` — greetings, help, SwiftUI, iOS, Xcode, Java code, and default replies all work.

---

## 📱 How to run

### iOS (Xcode)

1. Open `OfflineCursorBrain.xcodeproj` in Xcode.
2. Select iPhone simulator or your device.
3. **⌘R** to run.  
   On a real device: set **Signing & Capabilities** → **Team** to your Apple ID; trust the developer on the phone if prompted.

### Android (Android Studio)

1. Open the **BrainboxAndroid** folder in Android Studio.
2. Sync Gradle, then Run (▶) on an emulator or connected device.

**Or build APK from CLI:**

```bash
cd BrainboxAndroid
./gradlew assembleDebug
# APK: app/build/outputs/apk/debug/app-debug.apk
```

---

## 📁 Project structure

```
├── OfflineCursorBrain/          # iOS app (Swift/SwiftUI)
│   ├── OfflineCursorBrainApp.swift
│   ├── Models/ChatMessage.swift
│   ├── Services/LocalBrainService.swift, ChatStorage.swift
│   └── Views/ChatView.swift
├── BrainboxAndroid/             # Android app (Kotlin/Compose)
│   └── app/src/main/java/com/brainbox/app/
│       ├── MainActivity.kt, ChatScreen.kt
│       ├── BrainService.kt, ChatViewModel.kt
│       ├── ChatMessage.kt, ChatStorage.kt
│       └── BrainboxViewModelFactory.kt
├── TestBrainLogic.swift        # Offline brain logic test
├── HOW_IT_WORKS.md
├── PUBLISHING_GUIDE.md         # App Store & Play Store steps
└── README.md
```

---

## 🔒 Privacy

No data is sent off the device. All chat and logic run locally.

---

## 📄 License

Use and modify as you like. If you showcase this project (e.g. LinkedIn, portfolio), a mention is appreciated.

---

*Built for learning and offline-first development.*
