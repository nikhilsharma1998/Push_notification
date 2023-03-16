import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:push_notification_project/ReceivingNoti.dart';
import 'package:push_notification_project/main_screen.dart';

class NewestPage extends StatelessWidget {
  const NewestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Messaging"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Main Screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
            ),
            ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReceivingNoti()),
                  );
                }),
                child: const Text('For receive notification'))
          ],
        ),
      ),
    );
  }
}
