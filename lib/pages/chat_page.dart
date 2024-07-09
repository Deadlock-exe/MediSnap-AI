import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:medisnap/env.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final apiKey = Env.apikey;
    print('Retrieved API Key: $apiKey'); // Debug print
    if (apiKey.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("AI CHAT"),
        ),
        body: Center(
          child: Text('Please provide an API key.'),
        ),
      );
    }
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
    Future<String> generateAns(GenerativeModel model) async {
      final content = [Content.text('help with headache')];
      final response = await model.generateContent(content);
      return response.text ?? "can't generate nothing";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("AI CHAT"),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: generateAns(model),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Text(snapshot.data!);
            } else {
              return Text('Error: ${snapshot.error}');
            }
          },
        ),
      ),
    );
  }
}
