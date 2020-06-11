import 'package:flutter/material.dart';
import 'package:pageview_calendar/pageviewcalendar.dart';
import 'package:pageviewcalendar/pageviewcalendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: PageViewDemo(),
        ),
      ),
    );
  }
}

class PageViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Calculator calculator;
    return Container(
      child: Text("Test"),
    );
  }
}
