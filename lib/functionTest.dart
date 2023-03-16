import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification_project/main.dart';

class FunctionTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final _firestore = FirebaseFirestore.instance;
  final key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    requestPermission();
    firebaseMessaging.getToken().then((token) {
      saveTokens(token);
      print("Mera token $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("................OnMessage..............");
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}}");
      print("onData ${message.data['name']}}");
      Map<String, dynamic> myObject = {
        'name': message.data['name'],
        'email': message.data['email'],
        'phone': message.data['phone'],
      };
      print("pura data $myObject");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
      );
      if (kIsWeb) {
        print('web k andr aa chuke hai bhiya');
        if (message != null) {
          final title = message.notification?.title;
          final body = message.notification?.body;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Title: $title, Body: $body')),
          );
        }
      }
      AndroidNotificationDetails androidPlatformChannelSpecifies =
          AndroidNotificationDetails(
        'shopobid',
        'shopobid',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
        // sound: RawResourceAndroidNotificationSound('notification'),
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifies,
        //iOS: const IOSNotificationDetails());
      );
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['myObject']);
    });

    // firebaseMessaging.configure(
    //   //called when app is in foreground
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('init called onMessage');
    //     final snackBar = SnackBar(
    //       content: Text(message['notification']['body']),
    //       action: SnackBarAction(label: 'GO', onPressed: () {}),
    //     );
    //     key.currentState.showSnackBar(snackBar);
    //   },
    //called when app is completely closed and open from push notification
    // onLaunch: (Map<String, dynamic> message) async {
    //   print('init called onLaunch');
    // },
    // //called when app is in background  and open from push notification

    // onResume: (Map<String, dynamic> message) async {
    //   print('init called onResume');
    // },
    // );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      //String payload = message.data['myObject'];
      //print("payload k data $payload");
      //topic();
      print("opened background..........");
      print("opened background..........");
      //topic();
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional status');
    } else {
      print('User declined or has nott accepted permission');
    }
  }

  Future<void> saveTokens(var token) async {
    try {
      await _firestore.collection('tokens').add({
        'token': token,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Push Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
