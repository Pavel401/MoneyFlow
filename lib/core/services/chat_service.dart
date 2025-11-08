import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String apiUrl =
      'https://your-finance-bro-agent-production.up.railway.app/agent/chat';

  /// Send a message to the chat API and receive a streaming response
  /// The callback function will be called for each chunk of the response
  static Future<void> sendMessageStream({
    required String userQuery,
    required Map<String, dynamic> financeInfo,
    required List<Map<String, String>> chatHistory,
    required Function(String) onChunk,
    required Function() onComplete,
    required Function(String) onError,
  }) async {
    try {
      final requestBody = {
        'user_query': userQuery,
        'finance_info': financeInfo,
        'chat_history': chatHistory,
      };

      final request = http.Request('POST', Uri.parse(apiUrl));
      request.headers.addAll({
        'accept': '*/*',
        'accept-language': 'en-US,en;q=0.9',
        'content-type': 'application/json',
        'dnt': '1',
        'origin': 'https://your-finance-bro-agent-production.up.railway.app',
        'priority': 'u=1, i',
        'referer': 'https://your-finance-bro-agent-production.up.railway.app/',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'same-origin',
        'user-agent':
            'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1',
      });
      request.body = json.encode(requestBody);

      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        String buffer = '';
        String lastValidResponse = '';
        bool hasReceivedData = false;

        await for (var chunk in streamedResponse.stream.transform(
          utf8.decoder,
        )) {
          buffer += chunk;

          // Split by newlines to handle line-delimited JSON
          final lines = buffer.split('\n');

          // Process all complete lines except the last one (which might be incomplete)
          for (int i = 0; i < lines.length - 1; i++) {
            String line = lines[i].trim();

            // Skip empty lines
            if (line.isEmpty) continue;

            try {
              final responseData = json.decode(line);
              if (responseData['response_text'] != null) {
                lastValidResponse = responseData['response_text'];
                hasReceivedData = true;
                onChunk(lastValidResponse);
              }
            } catch (e) {
              // Try to handle multiple JSON objects concatenated without newlines (}{)
              if (line.contains('}{')) {
                final jsonObjects = line.split('}{');
                for (int j = 0; j < jsonObjects.length; j++) {
                  String jsonStr = jsonObjects[j];

                  // Add missing braces
                  if (!jsonStr.startsWith('{')) jsonStr = '{$jsonStr';
                  if (!jsonStr.endsWith('}')) jsonStr = '$jsonStr}';

                  try {
                    final responseData = json.decode(jsonStr);
                    if (responseData['response_text'] != null) {
                      lastValidResponse = responseData['response_text'];
                      hasReceivedData = true;
                      onChunk(lastValidResponse);
                    }
                  } catch (e2) {
                    print('JSON parse error (non-fatal): $e2');
                  }
                }
              } else {
                print('JSON parse error (non-fatal): $e');
              }
            }
          }

          // Keep the last incomplete line in the buffer
          buffer = lines.last;
        }

        // Process any remaining data in the buffer
        if (buffer.trim().isNotEmpty) {
          try {
            String line = buffer.trim();
            final responseData = json.decode(line);
            if (responseData['response_text'] != null) {
              lastValidResponse = responseData['response_text'];
              hasReceivedData = true;
              onChunk(lastValidResponse);
            }
          } catch (e) {
            print('Final buffer parse error (non-fatal): $e');
            // If buffer contains response_text, try to extract it
            if (buffer.contains('response_text') && buffer.contains('{')) {
              try {
                String fixedJson = buffer.trim();
                // Try to close incomplete JSON
                if (!fixedJson.endsWith('}')) {
                  int lastQuote = fixedJson.lastIndexOf('"');
                  if (lastQuote > 0) {
                    fixedJson = '${fixedJson.substring(0, lastQuote + 1)}}';
                    final responseData = json.decode(fixedJson);
                    if (responseData['response_text'] != null) {
                      lastValidResponse = responseData['response_text'];
                      hasReceivedData = true;
                      onChunk(lastValidResponse);
                    }
                  }
                }
              } catch (e2) {
                print('Could not recover from parse error: $e2');
              }
            }
          }
        }

        // Always call onComplete if we received any data
        if (hasReceivedData || lastValidResponse.isNotEmpty) {
          onComplete();
        } else {
          onError('No valid response received from server');
        }
      } else {
        onError(
          'Failed to get response. Status code: ${streamedResponse.statusCode}',
        );
      }
    } catch (e) {
      onError('Error sending message: $e');
    }
  }
}
