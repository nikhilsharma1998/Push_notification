import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_project/Authenticate/LoginScreen.dart';
import 'package:push_notification_project/NewestPage.dart';
import 'package:push_notification_project/functionTest.dart';
import 'package:push_notification_project/main_screen.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return MainScreen();
    } else {
      return LoginScreen();
    }
  }
}
