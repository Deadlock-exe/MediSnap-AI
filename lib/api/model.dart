import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:medisnap/env.dart';

final apiKey = Env.apikey;

final generationConfig = GenerationConfig(
  // maxOutputTokens: 100,
  temperature: 0.3,
  topP: 0.1,
  topK: 1,
  // temperature: 0.8,
  // topP: 0.9,
  // topK: 10,
);

final aiModel = GenerativeModel(
  model: 'gemini-1.5-flash',
  apiKey: apiKey,
  generationConfig: generationConfig,
);

Future<ChatSession> startChat(GenerativeModel model) async {
  final chat = model.startChat(history: [
    Content.text('Hello! How can I assist you today?'),
  ]);
  return chat;
}

Future<String> sendMessage(ChatSession chat, String message) async {
  final content = Content.text(message);
  final response = await chat.sendMessage(content);
  return response.text ?? "can't generate nothing";
}
