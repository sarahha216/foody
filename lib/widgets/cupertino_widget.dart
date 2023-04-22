import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDialogWidget {
  static base({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? voidCallback,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: voidCallback,
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }
}
