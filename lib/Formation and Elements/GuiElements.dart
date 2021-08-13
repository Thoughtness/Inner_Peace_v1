import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';

// ignore: camel_case_types
class CustomButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 0.0;

  CustomButton({
    required this.text,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, this.top, 0, this.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: onClick,
            child: Text(text),
            style: TextButton.styleFrom(
              side: BorderSide(width: 2.0, color: Colors.black),
              backgroundColor: Colors.cyanAccent,
              minimumSize: Size(0, 45),
              primary: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final textController;
  final String description;
  final String title;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 0.0;
  final double width = 10.0;
  final double containerWidth = 100.0;

  CustomRow({
    required this.title,
    required this.description,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: containerWidth,
          decoration: thinCyan(),
          child: ListTile(
            title: Text(title),
          ),
        ),
        SizedBox(width: width),
        Flexible(
          flex: 30,
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
        ), //SizedBox(width: width),
      ],
    );
  }
}

class SymptomsRow extends StatelessWidget {
  final String symptom;
  final int index;
  final String averageSymptom;
  final double symptomsValue;
  final List<Map<String, dynamic>> allIngredientsWithSymptoms;

  SymptomsRow({
    required this.symptom,
    required this.index,
    required this.averageSymptom,
    required this.symptomsValue,
    required this.allIngredientsWithSymptoms,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
      child: Row(
        children: [
          Container(
            width: 150,
            child: Text(symptom),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  flex: barLength(index, averageSymptom),
                  child: new Container(
                    decoration: BoxDecoration(
                      color: barColor(symptomsValue.toInt()),
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              20.0)),
                    ),
                    height: 20.0,
                  ),
                ),
                Flexible(
                  flex: opposingBarLength(index, averageSymptom),
                  child: SizedBox(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  barLength(int index, String symptom) {
    double barLength = allIngredientsWithSymptoms[index]['$symptom'] * 100;
    return barLength.toInt();
  }

  opposingBarLength(int index, String symptom) {
    double barLength = allIngredientsWithSymptoms[index]['$symptom'] * 100;
    double opposingBarLength = 1000 - barLength;
    return opposingBarLength.toInt();
  }

  barColor(int index) {
    Color color = Colors.black;

    if (index <= 3) {
      color = Colors.green;
    } else if (index <= 5) {
      color = Colors.yellow;
    } else if (index <= 8) {
      color = Colors.orange;
    } else if (index <= 10) {
      color = Colors.red;
    }
    return color;
  }
}
