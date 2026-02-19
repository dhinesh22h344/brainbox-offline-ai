package com.brainbox.app

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

class ChatStorage(context: Context) {
    private val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    fun load(): List<ChatMessage> {
        val json = prefs.getString(KEY_MESSAGES, null) ?: return emptyList()
        return try {
            val arr = JSONArray(json)
            (0 until arr.length()).map { i ->
                val obj = arr.getJSONObject(i)
                ChatMessage(
                    id = obj.optString("id", ""),
                    content = obj.optString("content", ""),
                    isFromUser = obj.optBoolean("isFromUser", false),
                    createdAt = obj.optLong("createdAt", 0L)
                )
            }
        } catch (_: Exception) {
            emptyList()
        }
    }

    fun save(messages: List<ChatMessage>) {
        val arr = JSONArray()
        messages.forEach { msg ->
            arr.put(JSONObject().apply {
                put("id", msg.id)
                put("content", msg.content)
                put("isFromUser", msg.isFromUser)
                put("createdAt", msg.createdAt)
            })
        }
        prefs.edit().putString(KEY_MESSAGES, arr.toString()).apply()
    }

    fun clear() {
        prefs.edit().remove(KEY_MESSAGES).apply()
    }

    companion object {
        private const val PREFS_NAME = "brainbox_chat"
        private const val KEY_MESSAGES = "messages"
    }
}
