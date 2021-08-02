import 'package:flutter/material.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Pages/RecordSymptoms.dart';

//import 'package:inner_peace/GuiElements.dart';
// ignore: camel_case_types
class PickMealForSymptoms extends StatefulWidget {
  PickMealForSymptoms({
    required this.symptomlessMeals,
  });
  final List<Map<String, dynamic>> symptomlessMeals;

  @override
  _PickMealForSymptoms createState() =>
      _PickMealForSymptoms(symptomlessMeals: symptomlessMeals);
}

class _PickMealForSymptoms extends State<PickMealForSymptoms> {
  _PickMealForSymptoms({
    required this.symptomlessMeals,
  });

  final List<Map<String, dynamic>> symptomlessMeals;

  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;
  final double width = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      endDrawer: menu(),
      appBar: AppBar(
        title: Text(
          'Mahlzeit wählen',
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
          Container(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              itemCount: symptomlessMeals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RecordSymptoms(
                          mealID: symptomlessMeals[index]['mealID'],
                        ),
                      ),
                    );
                  },
                  title: Container(
                    padding: EdgeInsets.fromLTRB(this.left, 0, 0, this.bottom),
                    decoration: myInnerBoxDecoration(),
                    child: Text(
                      symptomlessMeals[index]['meal'],
                      style: myTitleCyanAccentTextStyle(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
