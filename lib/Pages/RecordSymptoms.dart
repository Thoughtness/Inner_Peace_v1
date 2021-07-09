import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/GuiElements.dart';
// ignore: camel_case_types
class recordSymptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: menu(),
        appBar: AppBar(
          title: Text(
            'Symptome erfassen',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.cyanAccent,
        ),
        body: Column(
          children: <Widget>[
            new customSlider(title: 'Allgemeines Wohlbefinden', good: "Gut", bad: "Schlecht"),
            new customSlider(title: 'Krämpfe', good: "Keine", bad: "Extrem"),
            new customSlider(title: 'Blähungen', good: "Keine", bad: "Extrem"),
            new customSlider(title: 'Stuhlgang', good: "Fest", bad: "Flüssig"),
          ],
        ),
      );
}
