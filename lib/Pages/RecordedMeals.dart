import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/IngredientData.dart';
import 'package:inner_peace_v1/Database/MealData.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';

class RecordedMeals extends StatefulWidget {
  @override
  State createState() => new _RecordedMeals();
}

class _RecordedMeals extends State<RecordedMeals> {
  List<Map<String, dynamic>> mealList = [];

  bool checkAllMeals = false;
  bool imDone = false;

  getMealList(bool? value) async {
    mealList = [];
    var mealCount = await DatabaseHelper.instance.getMealID();
    int numbOfMeals = mealCount[0]['mealID'];
    for (int i = 1; i < numbOfMeals; i++) {
      var meal = await DatabaseHelper.instance.getRecordedMeals(i);
      mealList.add(meal[0]);
    }
      setState(() {
        checkAllMeals = value!;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      endDrawer: menu(),
      appBar: AppBar(
        title: Text(
          'Erfasste Mahlzeiten',
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
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            itemCount: mealList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(mealList[index]['meal'].toString()),
                      Text(mealList[index].toString())
                    ],
                  ),
                ),
              );
              // return Padding(
              //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              //   child: Row(
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           border: Border.all(width: 1.0),
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(5.0)),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //           child: Text(
              //             '${mealList[index].toString()}',
              //             style: TextStyle(height: 1.5, fontSize: 20),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            },
          ),
          Container(
            child: Column(
              children: <Widget>[
                CheckboxListTile(
                  title: Text("will this ever work"),
                  value: checkAllMeals,
                  onChanged: (bool? newValue) {
                    if(!checkAllMeals){
                      getMealList(newValue);
                    }
                    setState(() {
                      checkAllMeals = newValue!;
                    });
                    // }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // customCheckbox() async{
  //   getMealList();
  //   setState(() {
  //     checkAllMeals = newValue!;
  //   });
  // }
}

