import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/Database/IngredientData.dart';
import 'package:inner_peace_v1/Database/MealIngredientData.dart';
import 'package:inner_peace_v1/Main.dart';
import 'package:inner_peace_v1/Database/MealData.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Pages/RecordSymptoms.dart';

class RecordMeal extends StatefulWidget {
  @override
  State createState() => new _RecordMeal();
}

class _RecordMeal extends State<RecordMeal> {
  var mealName = TextEditingController();
  var ingredients = TextEditingController();

  final double width = 10.0;
  final double height = 20;
  List<IngredientData> ingredient = [];
  List<String> ingredientList = [];
  //set id(int id) {}
  //set meal(String meal) {}
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 0.0;

  //final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //=> Scaffold(
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
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image(
              image: AssetImage('assets/Inner_Peace.png'),
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              customRow(
                title: 'Gericht',
                description: 'Gericht hier benennen',
                textController: mealName,
              ),
              customRow(
                title: 'Zutaten',
                description: 'Zutaten einzeln hinzufügen',
                textController: ingredients,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    this.left, this.top, this.right, this.bottom),
                child: ElevatedButton(
                  onPressed: () async {
                    if (ingredients.text.length > 1) {
                      if (!ingredientList.contains(ingredients.text)) {
                        ingredientList.insert(0, ingredients.text);
                      }
                    }
                    ingredients.clear();
                    setState(() {});
                  },
                  child: Text("Zutat hinzufügen"),
                  style: TextButton.styleFrom(
                    side: BorderSide(width: 2.0, color: Colors.black),
                    backgroundColor: Colors.cyanAccent,
                    minimumSize: Size(0, 45),
                    primary: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  padding: const EdgeInsets.all(1),
                  itemCount: ingredientList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                '${ingredientList[index].toString()}',
                                style: TextStyle(height: 1.5, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 20,
                      child: customButton(
                        text: 'Symptome hinzufügen',
                        onClick: () {
                          //Damit keine leeren Einträge gemacht werden können
                          if (mealName.text.length > 0 && ingredientList.length > 0) {
                            addEntry();
                          }
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
                          //Damit keine leeren Einträge gemacht werden können
                          if (mealName.text.length > 0 && ingredientList.length > 0) {
                            addEntry();
                          }
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
              SizedBox(height: height),
            ],
          ),
        ],
      ),
    );
  }

  Future addEntry() async {
    //Mahlzeit in Tabelle einfügen
    var meal = MealData(
      meal: mealName.text,
    );
    await DatabaseHelper.instance.insertMeal(meal);
    var lastInsertedMeal = await DatabaseHelper.instance.getMealID();
    int mealID = lastInsertedMeal[0]['mealID'];

    //Zutaten in Tabelle einfügen
    for (int i = 0; i < ingredientList.length; i++) {
      var ingredients = IngredientData(
        ingredient: ingredientList[i],
      );
      await DatabaseHelper.instance.insertIngredient(ingredients);
    }

    //Alle Zutaten mit zugehörigen IDs holen
    List<IngredientData> ingredientListID = await DatabaseHelper.instance.getIngredientID();
    for (var i in ingredientListID) {
      //int ingredientID = i.in
      if(ingredientList.contains(i.ingredient)){
        var mealIngredient = MealIngredientData(
          mealID: mealID,
          ingredientID: i.ingredientID!,
        );
        await DatabaseHelper.instance.createMealIngredient(mealIngredient);
      }
    }
    // var seewhatwillcome = await DatabaseHelper.instance.getMealIngredient();
    // for (var i in seewhatwillcome) {
    //   print(i.mealID);
    //   print(i.ingredientID);
    // }
    // for (int i = 0; i < ingredientList.length; i++) {
    //   var ingredients = IngredientData(
    //     ingredient: ingredientList[i],
    //   );
    //   print("hallo"+ i.toString());
    //   await DatabaseHelper.instance.insertIngredient(ingredients);
    // }

  }

  // if (ingredients.text.length > 1) {
  //   var ingredient = IngredientData(
  //     ingredient: ingredients.text,
  //   );
  //   await DatabaseHelper.instance.insertIngredient(ingredient);
  // }

  // for (int i = 0; i == ingredientsArray.length; i++) {
  //   var ingredients = IngredientData(
  //     ingredient: ingredientsArray[i],
  //   );
  //   await DatabaseHelper.instance.insertIngredient(ingredients);
  // }

}
