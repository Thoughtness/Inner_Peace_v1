import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:flutter/widgets.dart';
import 'package:inner_peace_v1/Pages/RecordMeal.dart';
import 'package:inner_peace_v1/Pages/RecordedMeals.dart';
import 'package:inner_peace_v1/Pages/PickMealForSymptoms.dart';
import 'package:inner_peace_v1/Pages/Intolerances.dart';
import 'package:inner_peace_v1/Pages/Infos.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';

class MainMenu extends StatefulWidget {
  MainMenu({
    required this.userId
  });

  final int userId;

  @override
  _Mainmenu createState() => _Mainmenu(userId: userId);
}

class _Mainmenu extends State<MainMenu> {
  _Mainmenu({
    required this.userId
  });

  final int userId;

  final double left = 10.0;
  final double right = 10.0;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.teal[100],
    endDrawer: Menu(),
    appBar: AppBar(
      title: Text(
        'Hauptmenü',
        style: myAppBarTextStyle(),
      ),
      backgroundColor: Colors.cyanAccent,
    ),
    body: Stack(
      children: [
        Positioned.fill(
          child: Image(
            image: AssetImage('assets/Inner_Peace.png'),
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(left, 0, right, 0),
          child: Column(
            children: [
              CustomButton(
                text: "Mahlzeit erfassen",
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
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
                      builder: (context) => RecordedMeals(),
                    ),
                  );
                },
              ),
              CustomButton(
                text: "Symptome erfassen",
                onClick: () async {
                  var symptomlessMeals = await DatabaseHelper.instance.getSymptomlessMeals();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PickMealForSymptoms(
                          symptomlessMeals: symptomlessMeals),
                    ),
                  );
                },
              ),
              CustomButton(
                  text: "Unverträglichkeiten",
                  onClick: () async {
                    var warnings = await averageSymptomWithAmount("red");
                    var digestible = await averageSymptomWithAmount("yellow");
                    var symptomFree = await averageSymptomWithAmount("green");
                    var mealsFromIngredients = await DatabaseHelper.instance.getMealsFromIngredients();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Intolerances(
                          warnings: warnings, digestible: digestible, symptomFree: symptomFree,
                          mealsFromIngredients: mealsFromIngredients),
                    ));
                  }),
              CustomButton(
                text: "Infos",
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Infos(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
