import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/providers/analytics_provider.dart';
import 'package:moviedb/main_tab/main_tab_screen.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies.dart';
import 'package:moviedb/movie/widgets/summary/summary_detail.dart';
import 'package:moviedb/movie_firebase/movie_firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  Future<void> setupInteractedMessage(BuildContext context) async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.data['path']);
      print(message.data['id']);
      if(message.data['path'] == "/detail"){
        navigatorKey.currentState!.pushNamed("/detail", arguments: int.parse(message.data['id'].toString()));
      }else if(message.data['path'] != null){
        navigatorKey.currentState!.pushNamed(message.data['path']);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setupInteractedMessage(context);
    });

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Movie Data',
      navigatorObservers: [
        context.read(observerProvider)
      ],
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Color.fromRGBO(25, 25, 38, 100),
          textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          )),
      // home: MainTabScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainTabScreen(),
        '/detail': (context) => SummaryDetail(),
        '/firebase': (context) => MovieFirebase()
      }
    );
    }
  }
