//import 'dart:js';
//import 'package:path/path.dart' ;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification_project/Authenticate/Autheticate.dart';
import 'package:push_notification_project/functionTest.dart';
import 'package:push_notification_project/main.dart';
import 'package:push_notification_project/main.dart';
import 'package:push_notification_project/main_screen.dart';
import 'package:push_notification_project/navigatorKey.dart';
import 'package:push_notification_project/new_screen.dart';

import 'main.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
late String routeToGo = '/';

String? payload;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //String payload = message.data['myObject'];

// //final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  print('Handling a Background Message bahar se ${message.messageId}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDhBplEotbyUCro_lzTWR3PYJt15cF4U_Y",
      projectId: "findsonaweb",
      messagingSenderId: "688494126520",
      appId: "1:688494126520:web:a475410f690796aff5db4d",
    ));
  } else {
    await Firebase.initializeApp();
  }
  //await FirebaseMessaging.instance.getInitialMessage();
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    //   print("Before routToGo");
    payload = message.data['myObject'];
    routeToGo = "/newScreen";
    //   navigatorKey?.currentState?.pushNamed('/newScreen');
    //   print("After routToGo");
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    // Future<void> _firebaseMessagingBackgroundHandler(
    //     RemoteMessage message) async {
    //   String payload = message.data['myObject'];
    // }

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        //home: Authenticate(),
        debugShowCheckedModeBanner: false,
        // navigatorKey: navigatorKey,
        // routes: {
        //   "newScreen": (BuildContext context) => const NewPage(info: 'Hello'),
        //   "/": (BuildContext context) => Authenticate()
        // },

        initialRoute: (routeToGo != null) ? routeToGo : '/',
        // home: Authenticate(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (_) => Authenticate(),
              );
              break;
            case '/newScreen':
              return MaterialPageRoute(
                builder: (_) => NewPage(info: payload.toString()),
              );
              break;
            default:
              return _errorRoute();
          }
        });
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Icon(
                        Icons.delete_forever,
                        size: 48,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                          strokeWidth: 4, value: 1.0
                          // valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.withOpacity(0.5)),
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text('Page Not Found'),
              SizedBox(
                height: 10,
              ),
              Text(
                'Press back button on your phone',
                style: TextStyle(color: Color(0xff39399d), fontSize: 28),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
