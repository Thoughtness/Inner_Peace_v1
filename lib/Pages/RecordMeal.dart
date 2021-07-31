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
                      child: CustomButton(
                        text: 'Symptome hinzufügen',
                        onClick: () {
                          //Damit keine leeren Einträge gemacht werden können
                          if (mealName.text.length > 0 && ingredientList.length > 0) {
                            addEntry();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RecordSymptoms(),
                              ),
                            );
                          }
                          //todo: Meldung machen, dass keine Zutat gespeichert ist
                        },
                      ),
                    ),
                    Flexible(
                      flex: 20,
                      child: CustomButton(
                        text: 'Mahlzeit speichern',
                        onClick: () async {
                          //Damit keine leeren Einträge gemacht werden können
                          if (mealName.text.length > 0 && ingredientList.length > 0) {
                            addEntry();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ),
                            );
                            //todo: "Mahlzeit gespeichert" meldung erstellen
                          }
                          //todo: Meldung machen, dass keine Zutat gespeichert ist
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

    var lastInsertedMeal = await DatabaseHelper.instance.getHighestMealID();
    int mealID = lastInsertedMeal[0]['mealID'];

    //Zutaten in Tabelle einfügen
    for (int i = 0; i < ingredientList.length; i++) {
      var ingredients = IngredientData(
        ingredient: ingredientList[i],
      );
      await DatabaseHelper.instance.insertIngredient(ingredients);
    }

    //Alle Zutaten mit zugehörigen IDs holen und mealIngredients erstellen
    var ingredientListID = await DatabaseHelper.instance.getIngredients();
    print(ingredientListID.toString());
    for (var i in ingredientListID) {
      if(ingredientList.contains(i.ingredient)){
        // print(i.ingredientID);
        // await DatabaseHelper.instance.createMealIngredients(mealID, i.ingredientID);

        var mealIngredient = MealIngredientData(
          mealID: mealID,
          ingredientID: i.ingredientID!,
        );
        await DatabaseHelper.instance.createMealIngredient(mealIngredient);
      }
    }
  }
}

class customRow extends StatelessWidget {
  final textController;
  final String description;
  final String title;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 0.0;
  final double width = 10.0;
  customRow({
    required this.title,
    required this.description,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      child: Row(
        children: <Widget>[
          //SizedBox(width: width),
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5.0) //
                ),
              ),
              //height: 49,
              child: ListTile(
                title: Text(title),
              ),
            ),
          ),
          SizedBox(width: width),
          Flexible(
            flex: 3,
            child: Container(
              height: 58,
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: description),
                controller: textController,
              ),
            ),
          ),
          //SizedBox(width: width),
        ],
      ),
    );
  }
}