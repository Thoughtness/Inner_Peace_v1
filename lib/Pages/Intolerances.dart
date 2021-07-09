import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';

// ignore: camel_case_types
class unvertraeglichkeiten extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    endDrawer: menu(),
    appBar: AppBar(
      title: Text('Unverträglichkeiten',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.cyanAccent,
    ),
  );
}