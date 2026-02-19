package com.brainbox.app

data class ChatMessage(
    val id: String,
    val content: String,
    val isFromUser: Boolean,
    val createdAt: Long = System.currentTimeMillis()
)
