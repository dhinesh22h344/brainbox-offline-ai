package com.brainbox.app

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.coroutines.delay

/**
 * Offline "brain" — same logic as iOS app. No network.
 */
object BrainService {

    suspend fun respond(userMessage: String): String = withContext(Dispatchers.Default) {
        delay(100) // brief "thinking" feel
        respondSync(userMessage)
    }

    fun respondSync(userMessage: String): String {
        val trimmed = userMessage.trim().lowercase()
        if (trimmed.isEmpty()) return "Hi. Ask me anything — I run fully offline on your device."
        if (matches(trimmed, listOf("hi", "hello", "hey", "howdy"))) return "Hello! I'm Brainbox — your offline AI. I work without the internet. Ask for code (Java, Python, React, etc.) or tips!"
        if (matches(trimmed, listOf("help", "what can you do", "commands"))) return helpResponse()
        programmingResponse(trimmed)?.let { return it }
        if (containsAny(trimmed, listOf("cursor", "offline", "brain"))) return "Brainbox is your offline AI: chat and get answers without the internet. All processing happens on your device."
        return "Got it. I'm running fully offline. Try: \"Java code\", \"Python example\", \"React component\", or name any language/framework."
    }

    private fun matches(text: String, keywords: List<String>): Boolean = keywords.any { text == it || text.startsWith(it) }
    private fun containsAny(text: String, keywords: List<String>): Boolean = keywords.any { text.contains(it) }

    private fun helpResponse(): String = """
        I work **offline** on this device. You can:
        • Get code examples: Java, Python, JavaScript, Kotlin, C++, C#, Go, Swift, PHP, Ruby
        • Get framework tips: React, Angular, Vue, Django, Flask, Spring Boot, .NET, Node
        • Get iOS/Swift/SwiftUI/Xcode tips
        • Ask about concepts (OOP, async, APIs)

        I don't use the network — everything stays on your phone.
    """.trimIndent()

    private fun programmingResponse(text: String): String? {
        if (containsAny(text, listOf("react", "reactjs", "react js"))) return CodeSnippets.react
        if (containsAny(text, listOf("angular"))) return CodeSnippets.angular
        if (containsAny(text, listOf("vue", "vue.js", "vuejs"))) return CodeSnippets.vue
        if (containsAny(text, listOf("django"))) return CodeSnippets.django
        if (containsAny(text, listOf("flask"))) return CodeSnippets.flask
        if (containsAny(text, listOf("spring", "spring boot"))) return CodeSnippets.springBoot
        if (containsAny(text, listOf(".net", "asp.net", "dotnet"))) return CodeSnippets.dotNet
        if (containsAny(text, listOf("node", "node.js", "nodejs"))) return CodeSnippets.node
        if (containsAny(text, listOf("express"))) return CodeSnippets.express
        if (containsAny(text, listOf("swiftui", "swift ui"))) return CodeSnippets.swiftUI
        if (containsAny(text, listOf("swift"))) return CodeSnippets.swift
        if (containsAny(text, listOf("kotlin"))) return CodeSnippets.kotlin
        if (containsAny(text, listOf("python"))) return CodeSnippets.python
        if (containsAny(text, listOf("javascript", "js "))) return CodeSnippets.javascript
        if (containsAny(text, listOf("typescript", "ts "))) return CodeSnippets.typescript
        if (containsAny(text, listOf("java"))) return CodeSnippets.java
        if (containsAny(text, listOf("c++", "cpp"))) return CodeSnippets.cpp
        if (containsAny(text, listOf("c#", "csharp"))) return CodeSnippets.csharp
        if (containsAny(text, listOf("go", "golang"))) return CodeSnippets.go
        if (containsAny(text, listOf("rust"))) return CodeSnippets.rust
        if (containsAny(text, listOf("php"))) return CodeSnippets.php
        if (containsAny(text, listOf("ruby"))) return CodeSnippets.ruby
        if (containsAny(text, listOf("sql"))) return CodeSnippets.sql
        if (containsAny(text, listOf("html"))) return CodeSnippets.html
        if (containsAny(text, listOf("css"))) return CodeSnippets.css
        if (containsAny(text, listOf("ios", "xcode"))) return CodeSnippets.ios
        return null
    }
}

private object CodeSnippets {
    const val java = """
        Simple Java program:

        ```java
        public class HelloWorld {
            public static void main(String[] args) {
                System.out.println("Hello, World!");
            }
        }
        ```
        Save as HelloWorld.java → javac HelloWorld.java → java HelloWorld
    """.trimIndent()

    const val python = """
        Simple Python program:

        ```python
        def main():
            print("Hello, World!")

        if __name__ == "__main__":
            main()
        ```
        Run: python hello.py
    """.trimIndent()

    const val javascript = """
        Simple JavaScript (browser or Node):

        ```javascript
        console.log("Hello, World!");
        function greet(name) { return `Hello, ${name}!`; }
        ```
        Node: save as app.js → node app.js
    """.trimIndent()

    const val typescript = """
        Simple TypeScript:

        ```typescript
        function greet(name: string): string { return `Hello, ${name}!`; }
        console.log(greet("World"));
        ```
        Compile: tsc app.ts → node app.js (or use ts-node)
    """.trimIndent()

    const val kotlin = """
        Simple Kotlin program:

        ```kotlin
        fun main() {
            println("Hello, World!")
        }
        ```
        Run with Kotlin CLI or use in Android Studio.
    """.trimIndent()

    const val swift = """
        Simple Swift program:

        ```swift
        import Foundation
        print("Hello, World!")
        ```
        Run: swift hello.swift
    """.trimIndent()

    const val swiftUI = """
        SwiftUI tip + minimal view:

        ```swift
        import SwiftUI
        struct ContentView: View {
            var body: some View { VStack { Text("Hello, World!") } }
        }
        ```
        Use @State for state, @Binding to pass state to children.
    """.trimIndent()

    const val cpp = """
        Simple C++ program:

        ```cpp
        #include <iostream>
        int main() { std::cout << "Hello, World!" << std::endl; return 0; }
        ```
        Compile: g++ -o hello hello.cpp → ./hello
    """.trimIndent()

    const val csharp = """
        Simple C# program:

        ```csharp
        using System;
        class Program { static void Main() { Console.WriteLine("Hello, World!"); } }
        ```
        Run with: dotnet run (in a .NET project)
    """.trimIndent()

    const val go = """
        Simple Go program:

        ```go
        package main
        import "fmt"
        func main() { fmt.Println("Hello, World!") }
        ```
        Run: go run main.go
    """.trimIndent()

    const val rust = """
        Simple Rust program:

        ```rust
        fn main() { println!("Hello, World!"); }
        ```
        Run: rustc main.rs → ./main  or  cargo run
    """.trimIndent()

    const val php = """
        Simple PHP script:

        ```php
        <?php echo "Hello, World!\n"; ?>
        ```
        Run: php hello.php
    """.trimIndent()

    const val ruby = """
        Simple Ruby script:

        ```ruby
        puts "Hello, World!"
        ```
        Run: ruby hello.rb
    """.trimIndent()

    const val sql = """
        Basic SQL examples:

        ```sql
        SELECT * FROM users WHERE id = 1;
        INSERT INTO users (name) VALUES ('Alice');
        UPDATE users SET name = 'Bob' WHERE id = 1;
        ```
    """.trimIndent()

    const val html = """
        Minimal HTML page:

        ```html
        <!DOCTYPE html>
        <html><head><title>Hello</title></head>
        <body><h1>Hello, World!</h1></body></html>
        ```
    """.trimIndent()

    const val css = """
        Basic CSS:

        ```css
        body { font-family: sans-serif; }
        .box { padding: 1rem; border: 1px solid #ccc; }
        ```
    """.trimIndent()

    const val react = """
        Simple React component:

        ```jsx
        function App() {
            return <div><h1>Hello, World!</h1></div>;
        }
        export default App;
        ```
        Use useState for state, useEffect for side effects.
    """.trimIndent()

    const val angular = """
        Angular tip: component + template.

        ```typescript
        @Component({ selector: 'app-hello', template: '<h1>Hello, {{ name }}!</h1>' })
        export class HelloComponent { name = 'World'; }
        ```
    """.trimIndent()

    const val vue = """
        Simple Vue 3 component:

        ```vue
        <script setup>
        import { ref } from 'vue'
        const msg = ref('Hello, World!')
        </script>
        <template><h1>{{ msg }}</h1></template>
        ```
    """.trimIndent()

    const val django = """
        Minimal Django view:

        ```python
        from django.http import HttpResponse
        def hello(request): return HttpResponse("Hello, World!")
        ```
        Add URL in urls.py: path('hello/', views.hello).
    """.trimIndent()

    const val flask = """
        Minimal Flask app:

        ```python
        from flask import Flask
        app = Flask(__name__)
        @app.route('/')
        def hello(): return 'Hello, World!'
        ```
        Run: flask run
    """.trimIndent()

    const val springBoot = """
        Simple Spring Boot REST endpoint:

        ```java
        @RestController
        public class HelloController {
            @GetMapping("/hello")
            public String hello() { return "Hello, World!"; }
        }
        ```
    """.trimIndent()

    const val dotNet = """
        Minimal ASP.NET Core endpoint:

        ```csharp
        var builder = WebApplication.CreateBuilder(args);
        var app = builder.Build();
        app.MapGet("/", () => "Hello, World!");
        app.Run();
        ```
    """.trimIndent()

    const val node = """
        Minimal Node.js server:

        ```javascript
        const http = require('http');
        const server = http.createServer((req, res) => {
            res.writeHead(200); res.end('Hello, World!');
        });
        server.listen(3000);
        ```
    """.trimIndent()

    const val express = """
        Minimal Express.js app:

        ```javascript
        const express = require('express');
        const app = express();
        app.get('/', (req, res) => res.send('Hello, World!'));
        app.listen(3000);
        ```
    """.trimIndent()

    const val ios = """
        iOS/Swift tip: For offline apps use UserDefaults or SwiftData. Use async/await for async work. Xcode: Cmd+B build, Cmd+R run. SwiftUI: @State, @Binding, VStack/HStack.
    """.trimIndent()
}
