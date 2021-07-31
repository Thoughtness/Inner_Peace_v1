import 'package:flutter/material.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Pages/RecordSymptoms.dart';


//import 'package:inner_peace/GuiElements.dart';
// ignore: camel_case_types
class PickMealForSymptoms extends StatelessWidget {
  List<Map<String, dynamic>> mealList = [];
//todo methodenaufruf machen damit meallist gespeichert wird und danach setstate
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;
  final double width = 10.0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.teal[100],
        endDrawer: menu(),
        appBar: AppBar(
          title: Text(
            'Mahlzeit wählen',
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
            Container(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                itemCount: mealList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap:  () async {
                      //addEntry();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RecordSymptoms(),
                          ),
                        );
                        //todo: "Mahlzeit gespeichert" meldung erstellen
                      },
                      //todo: Meldung machen, dass keine Zutat gespeichert ist
                    title: Container(
                      decoration: myBoxDecoration(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: myInnerBoxDecoration(),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      this.left, 0, 0, this.bottom),
                                  child: Text(
                                      mealList[index]['meal'].toString(),
                                      style: myTitleCyanAccentTextStyle()),
                                ),
                                Spacer(),
                                //todo add info button (popup with all info)
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 24.0,
                                    color: Colors.red,
                                    onPressed: () async {
                                      //deleteMeal(index);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
