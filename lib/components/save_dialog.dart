import 'package:flutter/material.dart';

Future<String?> showSaveDialog(BuildContext context) async {
  String sessionName = '';

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Save Chat Session'),
        content: TextField(
          onChanged: (value) {
            sessionName = value;
          },
          decoration: const InputDecoration(
            hintText: "Enter session name",
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(sessionName);
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
