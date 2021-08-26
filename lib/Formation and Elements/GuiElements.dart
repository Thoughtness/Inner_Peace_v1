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
            style: buttonStyle(),
          ),
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
                  hintText: description,
              ),
              controller: textController,
            ),
          ),
        ), //SizedBox(width: width),
      ],
    );
  }
}

class SymptomsRow extends StatelessWidget {
  final String barName;
  final Color color;
  final List<Map<String, dynamic>> allIngredientsWithSymptoms;
  final barLength;
  final opposingBarLength;

  SymptomsRow({
    required this.barName,
    required this.color,
    required this.allIngredientsWithSymptoms,
    required this.barLength,
    required this.opposingBarLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
      child: Row(
        children: [
          Container(
            width: 150,
            child: Text(barName),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  flex: barLength,
                  child: new Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              20.0)),
                    ),
                    height: 20.0,
                  ),
                ),
                Flexible(
                  flex: opposingBarLength,
                  child: SizedBox(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

