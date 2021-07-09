import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/Database/IngredientData.dart';
import 'package:inner_peace_v1/Main.dart';
import 'package:inner_peace_v1/Database/MealData.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Pages/RecordSymptoms.dart';

// ignore: camel_case_types
class RecordMeal extends StatelessWidget {

  var mealName = TextEditingController();
  var ingredients = TextEditingController();
  List<String> ingredientsArray = [];
  List<MealData> taskList = [];

  final double width = 10.0;
  final double height = 20;

  set id(int id) {}
  set meal(String meal) {}

  //final formKey = new GlobalKey<FormState>();

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
                      //var ingredientID =
                      addEntry();
                      //print(await DatabaseHelper.instance.allMeals());
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

    var note = MealData(
        id : 0,
        meal : mealName.text,
    );
    var mealID = await DatabaseHelper.instance.insertMeal(note);
    //var maxIdResult = await db.rawQuery("SELECT MAX(id) as last_inserted_id FROM meal");
    //var id = maxIdResult.first["last_inserted_id"];


    for(int i = 0; i ==ingredientsArray.length; i++){
      var ingredientList = IngredientData(
        //todo make id change
          ingredientID: 0,
          ingredient: ingredientsArray[i],
      );
    }
  }
}