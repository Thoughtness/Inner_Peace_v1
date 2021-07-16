import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Main.dart';

// ignore: camel_case_types
class RecordSymptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.teal[100],
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
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image(
                image: AssetImage('assets/Inner_Peace.png'),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: <Widget>[
                new customSlider(title: 'Allgemeines Wohlbefinden', good: "Gut", bad: "Schlecht"),
                new customSlider(title: 'Krämpfe', good: "Keine", bad: "Extrem"),
                new customSlider(title: 'Blähungen', good: "Keine", bad: "Extrem"),
                new customSlider(title: 'Stuhlgang', good: "Fest", bad: "Flüssig"),
                Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 20,
                        child: customButton(
                          text: 'Symptome hinzufügen',
                          onClick: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RecordSymptoms(),
                              ),
                            );
                          },
                        ),
                      ),
                      Flexible(
                        flex: 20,
                        child: customButton(
                          text: 'Mahlzeit speichern',
                          onClick: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
