import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Pages/navigationMenu.dart';
// ignore: camel_case_types
class erfassteMahlzeiten extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    endDrawer: menu(),
    appBar: AppBar(
      title: Text('Erfasste Mahlzeiten',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.cyanAccent,
    ),
  );
}