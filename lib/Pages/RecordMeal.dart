import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/Database/IngredientData.dart';
import 'package:inner_peace_v1/Main.dart';
import 'package:inner_peace_v1/Database/MealData.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Pages/RecordSymptoms.dart';

class RecordMeal extends StatelessWidget {
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
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image(
                image: AssetImage('assets/Inner_Peace.png'),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              child: Column(
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
                        if(ingredients.text.length > 1) {
                          ingredientList.insert(0,ingredients.text);
                        }
                        //addIngredient();
                        ingredients.clear();
                        //ingredient = await DatabaseHelper.instance.allIngredients();
                        print(ingredientList);
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
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ingredientList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(ingredientList[index].toString())
                          ),
                        );

                        // return ListTile(
                        //   title: Text('${ingredient[index]}'),
                        // );
                      },
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 20,
                          child: customButton(
                            text: 'Symptome hinzufügen',
                            onClick: () {
                              addMeal();
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
                              print(mealName.text);
                              addMeal();
                              List<MealData> meals =
                                  await DatabaseHelper.instance.allMeals();
                              for (var i in meals) {
                                print(i.meal);
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
            ),
          ],
        ),
      );

  Future addMeal() async {
    var meal = MealData(
      meal: mealName.text,
    );

    await DatabaseHelper.instance.insertMeal(meal);
    //var maxIdResult = await db.rawQuery("SELECT MAX(id) as last_inserted_id FROM meal");
    //var id = maxIdResult.first["last_inserted_id"];

    // for (int i = 0; i == ingredientsArray.length; i++) {
    //   var ingredientList = IngredientData(
    //     //todo make id change
    //     ingredientID: 0,
    //     ingredient: ingredientsArray[i],
    //   );
    // }
  }

  Future addIngredient() async {
    if(ingredients.text.length > 1) {
      var ingredient = IngredientData(
        ingredient: ingredients.text,
      );
      await DatabaseHelper.instance.insertIngredient(ingredient);
    }

    // for (int i = 0; i == ingredientsArray.length; i++) {
    //   var ingredients = IngredientData(
    //     ingredient: ingredientsArray[i],
    //   );
    //   await DatabaseHelper.instance.insertIngredient(ingredients);
    // }
  }
  void addIngredientToList(){
      ingredientList.insert(0,ingredients.text);
  }
}
