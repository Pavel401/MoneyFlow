import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../../core/services/chat_service.dart';
import '../../core/services/export_service.dart';
import '../../data/models/database.dart';
import 'transaction_controller.dart';
import 'account_controller.dart';
import 'budget_controller.dart';

class ChatMessage {
  final String role;
  final String content;
  final DateTime timestamp;

  ChatMessage({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    role: json['role'],
    content: json['content'],
    timestamp: DateTime.parse(json['timestamp']),
  );

  Map<String, String> toApiFormat() => {'role': role, 'content': content};
}

class ChatController extends GetxController {
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final messages = <ChatMessage>[].obs;
  final isLoading = false.obs;
  final isSending = false.obs;
  final errorMessage = ''.obs;
  final historyLimit = 8.obs;

  static const _chatHistoryKey = 'chat_history';
  static const _historyLimitKey = 'chat_history_limit';

  @override
  void onInit() {
    super.onInit();
    _loadChatHistory();
    _loadHistoryLimit();
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> _loadChatHistory() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_chatHistoryKey);

      if (historyJson != null && historyJson.isNotEmpty) {
        final decoded = json.decode(historyJson) as List;
        messages.value = decoded.map((m) => ChatMessage.fromJson(m)).toList();
      }
    } catch (e) {
      print('Error loading chat: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadHistoryLimit() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      historyLimit.value = prefs.getInt(_historyLimitKey) ?? 8;
    } catch (e) {
      print('Error loading limit: $e');
    }
  }

  Future<void> updateHistoryLimit(int newLimit) async {
    if (newLimit < 1 || newLimit > 50) {
      errorMessage.value = 'Limit must be between 1 and 50';
      return;
    }
    historyLimit.value = newLimit;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_historyLimitKey, newLimit);
    } catch (e) {
      print('Error saving limit: $e');
    }
  }

  Future<void> _saveChatHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = json.encode(messages.map((m) => m.toJson()).toList());
      await prefs.setString(_chatHistoryKey, historyJson);
    } catch (e) {
      print('Error saving chat: $e');
    }
  }

  Future<Map<String, dynamic>> _getFinanceInfo() async {
    try {
      final now = DateTime.now();
      final thirtyDaysAgo = now.subtract(const Duration(days: 30));

      final transactions = Get.find<TransactionController>().transactions
          .where((t) => t.date.isAfter(thirtyDaysAgo))
          .toList();

      final accounts = Get.find<AccountController>().accounts.toList();

      final budgets = Get.find<BudgetController>().monthlyBudgets.map((m) {
        return Budget(
          id: const Uuid().v4(),
          year: m['year'] as int? ?? now.year,
          month: m['month'] as int? ?? now.month,
          amount: (m['amount'] as num?)?.toDouble() ?? 0.0,
          createdAt: now,
          updatedAt: now,
        );
      }).toList();

      final exportData = await ExportService.exportDataToString(
        transactions: transactions,
        accounts: accounts,
        budgets: budgets,
      );

      return json.decode(exportData);
    } catch (e) {
      print('Error getting finance info: $e');
      return {
        'exportInfo': {
          'exportDate': DateTime.now().toIso8601String(),
          'appVersion': '1.0.0',
          'dataFormat': 'json',
          'totalTransactions': 0,
          'totalAccounts': 0,
          'totalBudgets': 0,
        },
        'transactions': [],
        'accounts': [],
        'budgets': [],
      };
    }
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    int streamingIndex = -1;

    try {
      isSending.value = true;
      errorMessage.value = '';

      // Add user message
      messages.add(
        ChatMessage(
          role: 'user',
          content: message.trim(),
          timestamp: DateTime.now(),
        ),
      );
      messageController.clear();
      _scrollToBottom();
      await _saveChatHistory();

      // Get finance info and chat history
      final financeInfo = await _getFinanceInfo();
      final apiHistory = messages
          .skip(
            messages.length > historyLimit.value
                ? messages.length - historyLimit.value
                : 0,
          )
          .map((m) => m.toApiFormat())
          .toList();

      // Add placeholder for streaming
      final timestamp = DateTime.now();
      messages.add(
        ChatMessage(role: 'assistant', content: '', timestamp: timestamp),
      );
      streamingIndex = messages.length - 1;

      // Send to API
      await ChatService.sendMessageStream(
        userQuery: message.trim(),
        financeInfo: financeInfo,
        chatHistory: apiHistory,
        onChunk: (text) {
          if (streamingIndex >= 0 && streamingIndex < messages.length) {
            messages[streamingIndex] = ChatMessage(
              role: 'assistant',
              content: text,
              timestamp: timestamp,
            );
            messages.refresh();
            _scrollToBottom();
          }
        },
        onComplete: () async {
          if (streamingIndex >= 0 && messages[streamingIndex].content.isEmpty) {
            messages[streamingIndex] = ChatMessage(
              role: 'assistant',
              content: 'Sorry, no response received. Please try again.',
              timestamp: timestamp,
            );
          }
          await _saveChatHistory();
          _scrollToBottom();
        },
        onError: (error) {
          errorMessage.value = 'Failed: $error';
          if (streamingIndex >= 0) {
            messages[streamingIndex] = ChatMessage(
              role: 'assistant',
              content: 'Error: $error',
              timestamp: timestamp,
            );
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'Failed: $e';
      if (streamingIndex >= 0) {
        messages[streamingIndex] = ChatMessage(
          role: 'assistant',
          content: 'Error: $e',
          timestamp: DateTime.now(),
        );
      } else {
        messages.add(
          ChatMessage(
            role: 'assistant',
            content: 'Error: $e',
            timestamp: DateTime.now(),
          ),
        );
      }
    } finally {
      isSending.value = false;
    }
  }

  Future<void> clearChat() async {
    try {
      messages.clear();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_chatHistoryKey);
      errorMessage.value = '';
    } catch (e) {
      print('Error clearing chat: $e');
    }
  }

  Future<void> deleteUserHistory() async {
    try {
      messages.removeWhere((m) => m.role == 'user');
      await _saveChatHistory();
      errorMessage.value = '';
    } catch (e) {
      print('Error deleting user history: $e');
      errorMessage.value = 'Failed to delete user history';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
