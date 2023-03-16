import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReceivingNoti extends StatelessWidget {
  const ReceivingNoti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Firebase "),
        ),
        body: Center(
          child: Text('Receive notificaion'),
        ));
  }
}
