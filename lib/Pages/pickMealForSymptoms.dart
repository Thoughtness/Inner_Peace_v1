import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Pages/navigationMenu.dart';
//import 'package:inner_peace/guiElements.dart';
// ignore: camel_case_types
class pickMealForSymptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    endDrawer: menu(),
    appBar: AppBar(
      title: Text(
        'Mahlzeit wählen',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.cyanAccent,
    ),
    //body:
  );
}
