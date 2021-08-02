import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:flutter/widgets.dart';
import 'package:inner_peace_v1/Pages/RecordMeal.dart';
import 'package:inner_peace_v1/Pages/RecordedMeals.dart';
import 'package:inner_peace_v1/Pages/PickMealForSymptoms.dart';
import 'package:inner_peace_v1/Pages/Intolerances.dart';
import 'package:inner_peace_v1/Pages/Infos.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inner Peace',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.teal[100],
        endDrawer: menu(),
        appBar: AppBar(
          title: Text(
            'Hauptmenü',
            style: myAppBarTextStyle(),
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
                CustomButton(
                  text: "Mahlzeit erfassen",
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        //toDo save inputs
                        builder: (context) => RecordMeal(),
                      ),
                    );
                  },
                ),
                CustomButton(
                  text: "Erfasste Mahlzeiten",
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        //toDo save inputs
                        builder: (context) => RecordedMeals(),
                      ),
                    );
                  },
                ),
                CustomButton(
                  text: "Symptome erfassen",
                  onClick: () async {
                    var symptomlessMeals = await DatabaseHelper.instance.getSymptomlessMeals();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PickMealForSymptoms(symptomlessMeals: symptomlessMeals),
                      ),
                    );
                  },
                ),
                CustomButton(
                  text: "Unverträglichkeiten",
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        //toDo save inputs
                        builder: (context) => Intolerances(),
                      ),
                    );
                  },
                ),
                CustomButton(
                  text: "Infos",
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        //toDo save inputs
                        builder: (context) => Infos(),
                      ),
                    );
                  },
                ),
              ],
            ),

          ],
        ),
      );
}
