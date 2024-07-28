import 'package:flutter/material.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/provider/chat_provider.dart';
import 'package:medisnap/provider/nav_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<MyChatProvider>(context);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: primaryColor,
      ),
      body: ListView.builder(
        itemCount: chatProvider.getAllSessions().length,
        itemBuilder: (context, index) {
          final sessionKey = chatProvider.getAllSessions()[index];
          return ListTile(
            title: Text(
              sessionKey,
              style: TextStyle(color: textColor),
            ),
            onTap: () {
              final messages = chatProvider.getSession(sessionKey);
              chatProvider.loadSession(messages);
              Provider.of<NavProvider>(context, listen: false)
                  .toChatPage(false);
            },
          );
        },
      ),
    );
  }
}
