//
//  LocalBrainService.swift
//  OfflineCursorBrain
//
//  Offline “brain” — responds with code examples and tips for many languages & frameworks.
//  No network. Can be extended later with Core ML or on-device LLM.
//

import Foundation

enum LocalBrainService {

    /// Generates a response entirely on-device. No API calls.
    static func respond(to userMessage: String) async -> String {
        let trimmed = userMessage.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        // Greetings
        if trimmed.isEmpty {
            return "Hi. Ask me anything — I run fully offline on your device."
        }
        if matches(trimmed, ["hi", "hello", "hey", "howdy"]) {
            return "Hello! I'm Brainbox — your offline AI. I work without the internet. Ask for code (Java, Python, React, etc.) or tips!"
        }

        // Help
        if matches(trimmed, ["help", "what can you do", "commands"]) {
            return helpResponse()
        }

        // Programming languages & frameworks (code + tips)
        if let reply = programmingResponse(for: trimmed) {
            return reply
        }

        if containsAny(trimmed, ["cursor", "offline", "brain"]) {
            return "Brainbox is your offline AI: chat and get answers without the internet. All processing happens on your device."
        }

        return "Got it. I'm running fully offline. Try: \"Java code\", \"Python example\", \"React component\", \"SwiftUI tip\", or name any language/framework."
    }

    private static func matches(_ text: String, _ keywords: [String]) -> Bool {
        keywords.contains { text.hasPrefix($0) || text == $0 }
    }

    private static func containsAny(_ text: String, _ keywords: [String]) -> Bool {
        keywords.contains { text.contains($0) }
    }

    private static func helpResponse() -> String {
        """
        I work **offline** on this device. You can:
        • Get code examples: Java, Python, JavaScript, Kotlin, C++, C#, Go, Swift, PHP, Ruby
        • Get framework tips: React, Angular, Vue, Django, Flask, Spring Boot, .NET, Node
        • Get iOS/Swift/SwiftUI/Xcode tips
        • Ask about concepts (OOP, async, APIs)

        I don't use the network — everything stays on your phone.
        """
    }

    // MARK: - Programming languages & frameworks

    private static func programmingResponse(for text: String) -> String? {
        // Order: specific frameworks first, then languages
        if containsAny(text, ["react", "reactjs", "react js"]) { return CodeSnippets.react }
        if containsAny(text, ["angular"]) { return CodeSnippets.angular }
        if containsAny(text, ["vue", "vue.js", "vuejs"]) { return CodeSnippets.vue }
        if containsAny(text, ["django"]) { return CodeSnippets.django }
        if containsAny(text, ["flask"]) { return CodeSnippets.flask }
        if containsAny(text, ["spring", "spring boot"]) { return CodeSnippets.springBoot }
        if containsAny(text, [".net", "asp.net", "dotnet"]) { return CodeSnippets.dotNet }
        if containsAny(text, ["node", "node.js", "nodejs"]) { return CodeSnippets.node }
        if containsAny(text, ["express"]) { return CodeSnippets.express }
        if containsAny(text, ["swiftui", "swift ui"]) { return CodeSnippets.swiftUI }
        if containsAny(text, ["swift"]) { return CodeSnippets.swift }
        if containsAny(text, ["kotlin"]) { return CodeSnippets.kotlin }
        if containsAny(text, ["python"]) { return CodeSnippets.python }
        if containsAny(text, ["javascript", "js "]) { return CodeSnippets.javascript }
        if containsAny(text, ["typescript", "ts "]) { return CodeSnippets.typescript }
        if containsAny(text, ["java"]) { return CodeSnippets.java }
        if containsAny(text, ["c++", "cpp"]) { return CodeSnippets.cpp }
        if containsAny(text, ["c#", "csharp"]) { return CodeSnippets.csharp }
        if containsAny(text, ["go", "golang"]) { return CodeSnippets.go }
        if containsAny(text, ["rust"]) { return CodeSnippets.rust }
        if containsAny(text, ["php"]) { return CodeSnippets.php }
        if containsAny(text, ["ruby"]) { return CodeSnippets.ruby }
        if containsAny(text, ["sql"]) { return CodeSnippets.sql }
        if containsAny(text, ["html"]) { return CodeSnippets.html }
        if containsAny(text, ["css"]) { return CodeSnippets.css }
        if containsAny(text, ["ios", "xcode"]) { return CodeSnippets.ios }
        return nil
    }
}

// MARK: - Code snippets & tips (all offline)

private enum CodeSnippets {

    static let java = """
        Simple Java program:

        ```java
        public class HelloWorld {
            public static void main(String[] args) {
                System.out.println("Hello, World!");
            }
        }
        ```
        Save as HelloWorld.java → javac HelloWorld.java → java HelloWorld
        """

    static let python = """
        Simple Python program:

        ```python
        def main():
            print("Hello, World!")

        if __name__ == "__main__":
            main()
        ```
        Run: python hello.py
        """

    static let javascript = """
        Simple JavaScript (browser or Node):

        ```javascript
        console.log("Hello, World!");

        function greet(name) {
            return `Hello, ${name}!`;
        }
        ```
        Node: save as app.js → node app.js
        """

    static let typescript = """
        Simple TypeScript:

        ```typescript
        function greet(name: string): string {
            return `Hello, ${name}!`;
        }
        console.log(greet("World"));
        ```
        Compile: tsc app.ts → node app.js (or use ts-node)
        """

    static let kotlin = """
        Simple Kotlin program:

        ```kotlin
        fun main() {
            println("Hello, World!")
        }
        ```
        Run with Kotlin CLI or use in Android Studio.
        """

    static let swift = """
        Simple Swift program:

        ```swift
        import Foundation
        print("Hello, World!")
        ```
        Run: swift hello.swift
        """

    static let swiftUI = """
        SwiftUI tip + minimal view:

        ```swift
        import SwiftUI
        struct ContentView: View {
            var body: some View {
                VStack {
                    Text("Hello, World!")
                }
            }
        }
        ```
        Use @State for state, @Binding to pass state to children.
        """

    static let cpp = """
        Simple C++ program:

        ```cpp
        #include <iostream>
        int main() {
            std::cout << "Hello, World!" << std::endl;
            return 0;
        }
        ```
        Compile: g++ -o hello hello.cpp → ./hello
        """

    static let csharp = """
        Simple C# program:

        ```csharp
        using System;
        class Program {
            static void Main() {
                Console.WriteLine("Hello, World!");
            }
        }
        ```
        Run with: dotnet run (in a .NET project)
        """

    static let go = """
        Simple Go program:

        ```go
        package main
        import "fmt"
        func main() {
            fmt.Println("Hello, World!")
        }
        ```
        Run: go run main.go
        """

    static let rust = """
        Simple Rust program:

        ```rust
        fn main() {
            println!("Hello, World!");
        }
        ```
        Run: rustc main.rs → ./main  or  cargo run
        """

    static let php = """
        Simple PHP script:

        ```php
        <?php
        echo "Hello, World!\n";
        ?>
        ```
        Run: php hello.php
        """

    static let ruby = """
        Simple Ruby script:

        ```ruby
        puts "Hello, World!"
        ```
        Run: ruby hello.rb
        """

    static let sql = """
        Basic SQL examples:

        ```sql
        SELECT * FROM users WHERE id = 1;
        INSERT INTO users (name) VALUES ('Alice');
        UPDATE users SET name = 'Bob' WHERE id = 1;
        ```
        """

    static let html = """
        Minimal HTML page:

        ```html
        <!DOCTYPE html>
        <html>
        <head><title>Hello</title></head>
        <body>
          <h1>Hello, World!</h1>
        </body>
        </html>
        ```
        """

    static let css = """
        Basic CSS:

        ```css
        body { font-family: sans-serif; }
        .box { padding: 1rem; border: 1px solid #ccc; }
        #main { max-width: 800px; margin: 0 auto; }
        ```
        """

    static let react = """
        Simple React component:

        ```jsx
        function App() {
            return (
                <div>
                    <h1>Hello, World!</h1>
                </div>
            );
        }
        export default App;
        ```
        Use useState for state, useEffect for side effects.
        """

    static let angular = """
        Angular tip: component + template.

        ```typescript
        @Component({
            selector: 'app-hello',
            template: '<h1>Hello, {{ name }}!</h1>'
        })
        export class HelloComponent {
            name = 'World';
        }
        ```
        """

    static let vue = """
        Simple Vue 3 component:

        ```vue
        <script setup>
        import { ref } from 'vue'
        const msg = ref('Hello, World!')
        </script>
        <template>
          <h1>{{ msg }}</h1>
        </template>
        ```
        """

    static let django = """
        Minimal Django view:

        ```python
        from django.http import HttpResponse
        def hello(request):
            return HttpResponse("Hello, World!")
        ```
        Add URL in urls.py: path('hello/', views.hello).
        """

    static let flask = """
        Minimal Flask app:

        ```python
        from flask import Flask
        app = Flask(__name__)
        @app.route('/')
        def hello():
            return 'Hello, World!'
        ```
        Run: flask run
        """

    static let springBoot = """
        Simple Spring Boot REST endpoint:

        ```java
        @RestController
        public class HelloController {
            @GetMapping("/hello")
            public String hello() {
                return "Hello, World!";
            }
        }
        ```
        """

    static let dotNet = """
        Minimal ASP.NET Core endpoint:

        ```csharp
        var builder = WebApplication.CreateBuilder(args);
        var app = builder.Build();
        app.MapGet("/", () => "Hello, World!");
        app.Run();
        ```
        """

    static let node = """
        Minimal Node.js server:

        ```javascript
        const http = require('http');
        const server = http.createServer((req, res) => {
            res.writeHead(200);
            res.end('Hello, World!');
        });
        server.listen(3000);
        ```
        """

    static let express = """
        Minimal Express.js app:

        ```javascript
        const express = require('express');
        const app = express();
        app.get('/', (req, res) => res.send('Hello, World!'));
        app.listen(3000);
        ```
        """

    static let ios = """
        iOS/Swift tip: For offline apps use UserDefaults or SwiftData. Use async/await for async work. Xcode: Cmd+B build, Cmd+R run. SwiftUI: @State, @Binding, VStack/HStack.
        """
}
