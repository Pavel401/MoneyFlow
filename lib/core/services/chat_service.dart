import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  static const String _defaultBaseUrl =
      'https://your-finance-bro-agent-production.up.railway.app';
  static const String _baseUrlKey = 'chat_base_url';

  /// Get the current base URL from SharedPreferences
  static Future<String> getBaseUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_baseUrlKey) ?? _defaultBaseUrl;
    } catch (e) {
      return _defaultBaseUrl;
    }
  }

  /// Save a new base URL to SharedPreferences
  static Future<bool> setBaseUrl(String url) async {
    try {
      // Remove trailing slash if present
      final cleanUrl = url.trim().replaceAll(RegExp(r'/$'), '');

      // Basic URL validation
      if (!cleanUrl.startsWith('http://') && !cleanUrl.startsWith('https://')) {
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_baseUrlKey, cleanUrl);
    } catch (e) {
      return false;
    }
  }

  /// Reset to default base URL
  static Future<bool> resetBaseUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_baseUrlKey);
    } catch (e) {
      return false;
    }
  }

  /// Validate if a URL is reachable
  static Future<bool> validateUrl(String url) async {
    try {
      final cleanUrl = url.trim().replaceAll(RegExp(r'/$'), '');

      final response = await http
          .get(Uri.parse(cleanUrl))
          .timeout(const Duration(seconds: 5));

      return response.statusCode < 500; // Accept any non-server error
    } catch (e) {
      return false;
    }
  }

  static Future<void> sendMessageStream({
    required String userQuery,
    required Map<String, dynamic> financeInfo,
    required List<Map<String, String>> chatHistory,
    required Function(String) onChunk,
    required Function() onComplete,
    required Function(String) onError,
  }) async {
    try {
      final baseUrl = await getBaseUrl();
      final apiUrl = '$baseUrl/agent/chat';

      final request = http.Request('POST', Uri.parse(apiUrl));
      request.headers['content-type'] = 'application/json';
      request.body = json.encode({
        'user_query': userQuery,
        'finance_info': financeInfo,
        'chat_history': chatHistory,
      });

      final response = await request.send();

      if (response.statusCode != 200) {
        onError('Server error: ${response.statusCode}');
        return;
      }

      String buffer = '';
      bool hasData = false;

      await for (var chunk in response.stream.transform(utf8.decoder)) {
        buffer += chunk;
        final lines = buffer.split('\n');

        for (int i = 0; i < lines.length - 1; i++) {
          final line = lines[i].trim();
          if (line.isEmpty) continue;

          try {
            final data = json.decode(line);
            if (data['response_text'] != null) {
              hasData = true;
              onChunk(data['response_text']);
            }
          } catch (_) {}
        }

        buffer = lines.last;
      }

      // Process final buffer
      if (buffer.trim().isNotEmpty) {
        try {
          final data = json.decode(buffer.trim());
          if (data['response_text'] != null) {
            hasData = true;
            onChunk(data['response_text']);
          }
        } catch (_) {}
      }

      hasData ? onComplete() : onError('No response received');
    } catch (e) {
      onError('Error: $e');
    }
  }
}
