package com.brainbox.app

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

class ChatViewModel(context: Context) : ViewModel() {

    private val chatStorage = ChatStorage(context)

    private val _messages = MutableStateFlow<List<ChatMessage>>(emptyList())
    val messages: StateFlow<List<ChatMessage>> = _messages.asStateFlow()

    private val _isThinking = MutableStateFlow(false)
    val isThinking: StateFlow<Boolean> = _isThinking.asStateFlow()

    init {
        _messages.value = chatStorage.load()
    }

    fun sendMessage(text: String) {
        val content = text.trim()
        if (content.isEmpty()) return

        val userMsg = ChatMessage(id = java.util.UUID.randomUUID().toString(), content = content, isFromUser = true)
        _messages.value = _messages.value + userMsg
        chatStorage.save(_messages.value)
        _isThinking.value = true

        viewModelScope.launch {
            val reply = BrainService.respond(content)
            val botMsg = ChatMessage(id = java.util.UUID.randomUUID().toString(), content = reply, isFromUser = false)
            _messages.value = _messages.value + botMsg
            chatStorage.save(_messages.value)
            _isThinking.value = false
        }
    }

    fun clearChat() {
        _messages.value = emptyList()
        chatStorage.clear()
    }
}
