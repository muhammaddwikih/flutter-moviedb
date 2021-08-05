import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/main_tab/main_tab_screen.dart';
import 'package:moviedb/movie/widgets/detail/detail_movies.dart';
import 'package:moviedb/movie/widgets/summary/summary_detail.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Data',
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
      }
    );
    }
  }
