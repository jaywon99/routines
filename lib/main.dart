import 'package:flutter/material.dart';
import 'package:routines/widgets/home/page.dart';
import 'package:routines/widgets/about/page.dart';
import 'package:routines/widgets/routines/page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routines App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        // When navigating to the "/second" route, build the AboutPage widget.
        '/about': (context) => AboutPage(),
        '/routines': (context) => RoutineList(),
      },
      // When navigating to the "/" route, it will launch home property
      home: HomePage(title: 'Routines!'),
    );
  }
}

