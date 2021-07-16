import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/IngredientData.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
// ignore: camel_case_types
class RecordedMeals extends StatelessWidget{
  List<IngredientData> ingredient = [];
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.teal[100],
    endDrawer: menu(),
    appBar: AppBar(
      title: Text('Erfasste Mahlzeiten',
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
      ],
    ),
  );
}