import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final double left = 10.0;
  final double top = 0.0;
  final double right = 10.0;
  final double bottom = 10.0;

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
              decoration: customInputDecoration(description),
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
                    decoration: symptomsBar(color),
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

class CustomExpansionTile extends StatelessWidget {
  CustomExpansionTile({
    required this.title,
    required this.textToTitle,
    required this.bot,
    required this.decoration,
  });

  final String title;
  final String textToTitle;
  final double bot;
  final Decoration decoration;

  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, bot),
      child: Container(
        decoration: decoration,
        child: ExpansionTile(
          title: Text(title),
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                decoration: topSquareGrey(),
                child: Text(textToTitle)),
          ],
        ),
      ),
    );
  }
}

class InfoEntry extends StatelessWidget {
  InfoEntry({
    required this.title,
    required this.explanation,
    required this.titleCauses,
    required this.causes,
    required this.titlePrevent,
    required this.prevent,
    required this.titleCure,
    required this.cure,
    required this.source,
  });

  final String title;
  final String explanation;
  final String titleCauses;
  final String causes;
  final String titlePrevent;
  final String prevent;
  final String titleCure;
  final String cure;
  final String source;

  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, bottom),
      child: Container(
        decoration: thickCyan(),
        child: ClipRRect(
          child: ExpansionTile(
            title: Text(
              title,
              style: myTextStyleMedium(),
            ),
            children: [
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                  decoration: topSquareGrey(),
                  child: Text(explanation)),
              CustomExpansionTile(
                title: titleCauses,
                textToTitle: causes,
                bot: 0,
                decoration: thinSquare(),
              ),
              CustomExpansionTile(
                title: titlePrevent,
                textToTitle: prevent,
                bot: 0,
                decoration: thinSquare(),
              ),
              CustomExpansionTile(
                title: titleCure,
                textToTitle: cure,
                bot: 0,
                decoration: thinSquare(),
              ),
              CustomExpansionTile(
                title: 'Quelle',
                textToTitle: source,
                bot: 0,
                decoration: thinSquare(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
