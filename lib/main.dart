import 'package:flutter/material.dart';
import './widgets/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestSMS',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(title: 'TestSMS'),
    );
  }
}
