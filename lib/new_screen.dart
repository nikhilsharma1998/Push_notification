import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewPage extends StatelessWidget {
  final String info;

  const NewPage({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decodedMap = json.decode(info);
    print("ye rha naam ${decodedMap['Name']}");
    print(decodedMap['Email']);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Firebase Messaging"),
        ),
        body: Center(
          child: Text(decodedMap['Name']), // If I only want to show name
        ));
  }
}
