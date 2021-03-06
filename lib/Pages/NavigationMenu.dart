import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/Pages/LoginPage.dart';
import 'package:inner_peace_v1/Pages/RecordedMeals.dart';
import 'package:inner_peace_v1/Pages/Infos.dart';
import 'package:inner_peace_v1/Pages/RecordMeal.dart';
import 'package:inner_peace_v1/Pages/PickMealForSymptoms.dart';
import 'package:inner_peace_v1/Pages/Intolerances.dart';
import 'package:inner_peace_v1/Pages/MainMenu.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';
import 'Instructions.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Material(
        color: Colors.cyanAccent,
        child: ListView(
          children: [
          SizedBox(height: 15),
          ListTile(
              leading: Icon(Icons.menu),
              title: Text('Hauptmenü'),
              onTap: () async {
                var warnings = await filteredAverageSymptomsListWithAmount('red');
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MainMenu(warnings: warnings),
                ));
              }
          ),
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Mahlzeit erfassen'),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RecordMeal(),
              ));
            }
          ),
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Erfasste Mahlzeiten'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RecordedMeals(),
                ));
              }
          ),
          SizedBox(height: 15),
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
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('Unverträglichkeiten'),
              onTap: () async{
                var warnings = await filteredAverageSymptomsListWithAmount('red');
                var digestible = await filteredAverageSymptomsListWithAmount('yellow');
                var symptomFree = await filteredAverageSymptomsListWithAmount('green');
                var mealsFromIngredients = await DatabaseHelper.instance.getMealsFromIngredients();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Intolerance(warnings: warnings, digestible: digestible, symptomFree: symptomFree, mealsFromIngredients: mealsFromIngredients),
                ));
              }
          ),
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.format_list_bulleted),
            title: Text('Infos'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Info(),
                ));
              }
          ),
          SizedBox(height: 15),
          ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('Bedienungsanleitung'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Instructions(),
                ));
              }
          ),
          SizedBox(height: 15),
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
    );
  }
}

