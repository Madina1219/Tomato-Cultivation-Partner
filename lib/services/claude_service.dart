import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_keys.dart';

/// Service that talks to Claude (Anthropic API).
/// Takes a tomato photo + user question, returns friendly advice.
class ClaudeService {
  static const String _apiUrl = 'https://api.anthropic.com/v1/messages';
  static const String _model = 'claude-sonnet-4-6';

  /// The personality of the Tomato Companion.
  /// This system prompt makes Claude reply like a warm, knowledgeable friend.
  static const String _systemPrompt = '''
You are the Tomato Companion — a warm, encouraging gardening friend who specializes in tomato cultivation. You help home growers care for their tomato plants.

When the user shows you a photo of their tomato plant, respond in this exact structure:

1. **Opening line**: A short, warm greeting that reacts to what you see (e.g. "Looking good!" or "Let's take a closer look").

2. **What I noticed**: 2-3 sentences describing the plant's current state — colour, leaf shape, signs of health or stress. Be specific but kind.

3. **Do this today**: A numbered list of 2-4 concrete actions the grower can take right now. Use emojis (💧 ☀️ 🪴 🌱) at the start of each item.

4. **Coming up**: One sentence about what to expect in the next 1-3 weeks.

Keep the whole response under 200 words. Use markdown formatting (bold, lists). Never diagnose serious disease without saying "it might be" — stay encouraging. If the photo isn't a tomato plant, gently say so and ask for a tomato photo.
''';

  /// Sends a photo + question to Claude and returns the response text.
  ///
  /// [imageFile] — the photo the user took or picked
  /// [userQuestion] — optional extra context like "yellow leaves appeared 2 days ago"
  Future<String> analyzeTomato({
    required File imageFile,
    String userQuestion = '',
  }) async {
    // Step 1: Convert image to base64 (the format Claude's API expects)
    final imageBytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    // Step 2: Detect image type from file extension
    final extension = imageFile.path.split('.').last.toLowerCase();
    final mediaType = (extension == 'png') ? 'image/png' : 'image/jpeg';

    // Step 3: Build the message Claude will see
    final userMessage = userQuestion.isEmpty
        ? 'Please look at my tomato plant and give me guidance.'
        : 'Please look at my tomato plant. Extra context: $userQuestion';

    // Step 4: Build the HTTP request body
    final requestBody = {
      'model': _model,
      'max_tokens': 1024,
      'system': _systemPrompt,
      'messages': [
        {
          'role': 'user',
          'content': [
            {
              'type': 'image',
              'source': {
                'type': 'base64',
                'media_type': mediaType,
                'data': base64Image,
              },
            },
            {
              'type': 'text',
              'text': userMessage,
            },
          ],
        },
      ],
    };

    // Step 5: Send the request to Claude
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': ApiKeys.anthropic,
          'anthropic-version': '2023-06-01',
        },
        body: jsonEncode(requestBody),
      );

      // Step 6: Check the response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final textBlock = data['content'][0]['text'] as String;
        return textBlock;
      } else {
        // Claude returned an error — let's see what it says
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error']?['message'] ?? 'Unknown error';
        throw Exception('Claude API error (${response.statusCode}): $errorMessage');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      throw Exception('Failed to analyze tomato: $e');
    }
  }
}