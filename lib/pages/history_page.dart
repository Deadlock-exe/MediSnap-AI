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
    final allSessions = chatProvider.getAllSessions();

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          "Chat History",
          style: TextStyle(
            color: secondaryColor,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert_outlined,
              size: 25,
              color: textColor,
            ),
            onSelected: (value) {
              if (value == 'Delete History') {
                chatProvider.clearAllSessions();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('All chat history has been deleted'),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Delete History'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: allSessions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save,
                    size: 100,
                    color: secondaryColor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "No saved history",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(6),
              child: ListView.builder(
                itemCount: allSessions.length,
                itemBuilder: (context, index) {
                  final sessionKey = chatProvider.getAllSessions()[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 31, 31, 46),
                            offset: Offset(1, 1),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: const Color.fromARGB(255, 89, 89, 102),
                            offset: Offset(-1, -1),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(6),
                      child: ListTile(
                        title: Text(
                          sessionKey,
                          style: TextStyle(color: textColor),
                        ),
                        tileColor: secondaryColor,
                        leading: Icon(
                          Icons.history,
                          color: secondaryColor,
                          size: 25,
                        ),
                        onTap: () {
                          final messages = chatProvider.getSession(sessionKey);
                          chatProvider.loadSession(messages);
                          Provider.of<NavProvider>(context, listen: false)
                              .toChatPage(false);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
