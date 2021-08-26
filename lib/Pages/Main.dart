import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Pages/LoginPage.dart';
import 'package:flutter/widgets.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inner Peace',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage(),
      );
}

