import 'package:flutter/material.dart';
import 'package:inner_peace_v1/DatabaseHelper.dart';
import 'package:inner_peace_v1/main.dart';
import 'package:inner_peace_v1/mealData.dart';
import 'package:inner_peace_v1/Pages/navigationMenu.dart';
import 'package:inner_peace_v1/guiElements.dart';
import 'package:inner_peace_v1/Pages/recordSymptoms.dart';

// ignore: camel_case_types
class recordMeal extends StatelessWidget {

  var mealName = TextEditingController();
  var ingredients = TextEditingController();
  List<String> ingredientsArray = [];
  List<mealData> taskList = [];

  String symptoms = "";
  final double width = 10.0;
  final double height = 20;

  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.teal[100],
    endDrawer: menu(),
    appBar: AppBar(
      title: Text(
        'Mahlzeit erfassen',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.cyanAccent,
    ),
    body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: height),
          customRow(
            title: 'Gericht',
            description: 'Gericht hier benennen',
            textController: mealName,
          ),
          SizedBox(height: height),
          customRow(
            title: 'Zutaten',
            description: 'Zutaten mit Komma trennen',
            textController: ingredients,
          ),
          // Expanded(
          //   child: Container(
          //     child: taskList.isEmpty
          //         ? Container()
          //         : ListView.builder(itemBuilder: (ctx, index) {
          //             //if (index == taskList.length) return null;
          //             return ListTile(
          //               title: Text(taskList[index].gericht),
          //               leading: Text(taskList[index].id.toString()),
          //             );
          //           }),
          //   ),
          // ),
          Flexible(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 10),
                Flexible(
                  flex: 20,
                  child: customButton(
                    text: 'Symptome hinzufügen',
                    onClick: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          //toDo save inputs
                          builder: (context) => recordSymptoms(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: width),
                Flexible(
                  flex: 20,
                  child: customButton(
                    text: 'Mahlzeit speichern',
                    onClick: () async {
                      ingredientsArray = ingredients.text.split(',');
                      print(mealName.text);
                      print(ingredientsArray);
                      addEntry();
                      print(await DatabaseHelper.instance.meals());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          //toDo save inputs
                          builder: (context) => MyApp(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: width),
              ],
            ),
          ),
          SizedBox(height: height),
        ],
      ),
    ),
  );


  Future addEntry() async {

    var note = mealData(
      meal: mealName.text,
      ingredients: ingredients.text,
      // symptomTotal: symptomTotal,
      // generalWellbeing: generalWellbeing,
      // cramps: cramps,
      // flatulence: flatulence,
      // bowel: bowel,
    );

    await DatabaseHelper.instance.insertMeal(note);
  }
}
