import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification_project/Authenticate/Methods.dart';
import 'package:push_notification_project/main.dart';
import 'package:push_notification_project/new_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String token;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  TextEditingController username = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
    initInfo();
    //topic();
  }

  initInfo() {
    //print("welcome initinfo");

    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/shopobid');
    //var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (payload) async {
      try {
        if (payload != null) {
          print("payload k andr h");
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            print("payload k bhot andr");
            return NewPage(info: payload.payload.toString());
          }));
        } else {
          print("payload error");
        }
      } catch (e) {
        print("payload ka error");
      }
      return;
    });
    //print("................beforeOnMessage..............");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // String payload = message.data['myObject'];
      print("................OnMessage..............");
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}}");
      String payload = message.data['myObject'];
      print("payload k data $payload");
      // print(message.data);

      try {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return NewPage(info: payload.toString());
        }));
      } catch (e) {
        print("we are an error");
        print(e.toString());
      }
      topic();
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
        //topic();
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

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      String payload = message.data['myObject'];
      //print("payload k data $payload");
      //topic();
      print("opened background..........");
      print("opened background..........");
      //topic();
      try {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return NewPage(info: payload.toString());
        }));
      } catch (e) {
        print("we are an error");
        print(e.toString());
      }
    });
  }

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    var emailId = FirebaseAuth.instance.currentUser!.email;

    await FirebaseFirestore.instance.collection('users').doc(emailId).update({
      'token': token,
    });
  }

  Future<void> getToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BOA9JOc1l6Mkei4I_I03qze_PKVCGhbB54xCdxiAH_PweArUdG-P9DSyxpm19-eRONw-T7HwCFk21Za1sFuGH2o");

    // Save the initial token to the database
    await saveTokenToDatabase(token!);
    print("My token is $token");

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
    // print("naya token $token");
  }

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       mtoken = token;
  //       print("My token is $mtoken");
  //     });

  //     saveToken(token!);
  //   });

  //   // await FirebaseMessaging().onTokenRefresh.listen((newToken) {
  //   //   // Save newToken
  //   // });
  // }

  // void saveToken(String token) async {
  //   String userId = FirebaseAuth.instance.currentUser!.uid;
  //   await FirebaseFirestore.instance.collection('users').doc(userId).update({
  //     'token': FieldValue.arrayRemove([token]),
  //   });
  // }

  void topic() async {
    print("topic k andr");
    try {
      print("try k andr");
      var _token =
          "c6pjCNwaicBq6Br8O6UnvS:APA91bHBrdG0SQ0Z00YYnYoK33ctUbx3JaWvfqXSspRAcgqOOcUyXlDB65DwSN3LoyRJyMkRZSztZTEi-CMw5kRxWPpDMQ48fh-r9DTDsXecXC2mU62Yb5p8DP45MNFNd1yaCjE7ONQL";
      Uri.parse('https://iid.googleapis.com/iid/v1/' +
          _token +
          '/rel/topics/' +
          "Indore");
      headers:
      <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAoE1ypbg:APA91bGEPL0Yd99hS-mXWcYwcnyYtAkys_wPUB76UjwS-KtBIAhtxoLaku7nfXeAnIR78hxR8qMli3j0nJe7mCQk7zA8hjbAOPyI-mfq66AnvXzQz8KrJu--GE7Qxxpc6HGyp7qu1My0'
      };
      print("try k bahr");
    } catch (e) {
      print("topic m error");
    }
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

  void sendPushMessage(
    String token,
    String title,
    String body,
    Map myObject,
  ) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAoE1ypbg:APA91bGEPL0Yd99hS-mXWcYwcnyYtAkys_wPUB76UjwS-KtBIAhtxoLaku7nfXeAnIR78hxR8qMli3j0nJe7mCQk7zA8hjbAOPyI-mfq66AnvXzQz8KrJu--GE7Qxxpc6HGyp7qu1My0',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'title': title,
              'body': body,
              'myObject': myObject
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "myObject": myObject,
              "android_channel_id": "shopobid"
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: username,
            ),
            TextFormField(
              controller: title,
            ),
            TextFormField(
              controller: body,
            ),
            GestureDetector(
              onTap: () async {
                String name = username.text.trim();
                String titleText = title.text;
                String bodyText = body.text;

                if (name != "") {
                  DocumentSnapshot snap = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(name)
                      .get();
                  String token = snap['token'];
                  print("firebase ka token $token");

                  String uid = snap['uid'];
                  print("user ki id $uid");

                  DocumentSnapshot documentSnapshot = await FirebaseFirestore
                      .instance
                      .collection("userData")
                      .doc(uid)
                      .get();

                  // String uuid = snap['uid'];
                  //print("userData ki id $uuid");

                  String userName;
                  String email;
                  String status;
                  print("userData ki id gdfgfg ");

                  //void showDisplayName() async {

                  var collection =
                      FirebaseFirestore.instance.collection('userData');

                  var docSnapshot = await collection.doc(uid).get();

                  Map<String, dynamic> data = docSnapshot.data()!;

                  userName = data['name'];
                  email = data['email'];
                  status = data['status'];

                  Map<String, dynamic> myObject = {
                    'Name': userName,
                    'Email': email,
                    'status': status,
                    'uid': uid
                  };

                  print(myObject);

                  sendPushMessage(token, titleText, bodyText, myObject);
                }
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.5),
                      )
                    ]),
                child: Center(child: const Text("button")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
