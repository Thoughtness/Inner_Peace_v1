import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/Pages/LoginPage.dart';
import 'package:inner_peace_v1/Pages/RecordedMeals.dart';
import 'package:inner_peace_v1/Pages/Infos.dart';
import 'package:inner_peace_v1/Pages/RecordMeal.dart';
import 'package:inner_peace_v1/Pages/PickMealForSymptoms.dart';
import 'package:inner_peace_v1/Pages/Intolerances.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Material(
        color: Colors.cyanAccent,
        child: ListView(
          children: [
          Container(
            child: Column(
              children: [
                const SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.fastfood),
                  title: Text('Mahlzeit erfassen'),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RecordMeal(),
                    ));
                  }
                ),
                const SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.fastfood),
                  title: Text('Erfasste Mahlzeiten'),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RecordedMeals(),
                      ));
                    }
                ),
                const SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.air),
                  title: Text('Symptome erfassen'),
                    onTap: () async{
                      var symptomlessMeals = await DatabaseHelper.instance.getSymptomlessMeals();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PickMealForSymptoms(symptomlessMeals: symptomlessMeals),
                      ));
                    }
                ),
                const SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.show_chart),
                  title: Text('Unverträglichkeiten'),
                    onTap: () async{
                      var warnings = await filteredAverageSymptomsListWithAmount( "red");
                      var digestible = await filteredAverageSymptomsListWithAmount("yellow");
                      var symptomFree = await filteredAverageSymptomsListWithAmount("green");
                      var mealsFromIngredients = await DatabaseHelper.instance.getMealsFromIngredients();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Intolerances(warnings: warnings, digestible: digestible, symptomFree: symptomFree, mealsFromIngredients: mealsFromIngredients),
                      ));
                    }
                ),
                const SizedBox(height: 15),
                ListTile(
                  leading: Icon(Icons.format_list_bulleted),
                  title: Text('Infos'),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Infos(),
                      ));
                    }
                ),
                const SizedBox(height: 15),
                ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Ausloggen'),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                    }
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

