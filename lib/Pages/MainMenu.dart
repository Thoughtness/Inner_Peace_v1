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
    required this.warnings,
  });

  final List<Map<String, dynamic>> warnings;

  @override
  _MainMenu createState() => _MainMenu(warnings: warnings);
}

class _MainMenu extends State<MainMenu> {
  _MainMenu({
    required this.warnings,
  });

  final List<Map<String, dynamic>> warnings;
  List<Map<String, dynamic>> digestible = [];
  List<Map<String, dynamic>> symptomFree = [];
  final double left = 10.0;
  final double right = 10.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
              padding: EdgeInsets.fromLTRB(left, 10, right, 10),
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
                      var symptomlessMeals =
                          await DatabaseHelper.instance.getSymptomlessMeals();
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
                        //warnings = await filteredAverageSymptomsListWithAmount("red");
                        digestible =
                            await filteredAverageSymptomsListWithAmount(
                                "yellow");
                        symptomFree =
                            await filteredAverageSymptomsListWithAmount(
                                "green");
                        var mealsFromIngredients = await DatabaseHelper.instance
                            .getMealsFromIngredients();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Intolerances(
                              warnings: warnings,
                              digestible: digestible,
                              symptomFree: symptomFree,
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
                  Expanded(
                    child: Container(
                      decoration: thickGrey(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: thinRed(),
                            child: Text("Warnungen",
                                style: myTextStyleMediumThick()),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            itemCount: warnings.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Container(
                                  decoration: thinCyan(),
                                  child: Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(left, 0, 0, 10),
                                      child: FittedBox(
                                        alignment: Alignment.topLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Text(warnings[index]['meal'],
                                            style:
                                                myTitleCyanAccentTextStyle()),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
