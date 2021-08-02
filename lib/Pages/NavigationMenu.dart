import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/Pages/RecordedMeals.dart';
import 'package:inner_peace_v1/Pages/Infos.dart';
import 'package:inner_peace_v1/Pages/RecordMeal.dart';
import 'package:inner_peace_v1/Pages/PickMealForSymptoms.dart';
import 'package:inner_peace_v1/Pages/Intolerances.dart';
// ignore: camel_case_types
class menu extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Material(
        color: Colors.cyanAccent,
        child: ListView(
          children: <Widget>[
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
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Intolerances(),
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
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }

  symptomlessMeals() async {

    var symptomlessMealCount = await DatabaseHelper.instance.getSymptomlessMeals();

    return symptomlessMealCount;
    // setState(() {
    //   filter = value!;
    // });
  }
}