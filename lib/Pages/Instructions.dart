import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/Formation.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/Text.dart';

import 'NavigationMenu.dart';

class Instructions extends StatelessWidget {

  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.teal[100],
        endDrawer: Menu(),
        appBar: AppBar(
          title: Text(
            'Bedienungsanleitung',
            style: myAppBarTextStyle(),
          ),
          backgroundColor: Colors.cyanAccent,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: AssetImage('assets/Inner_Peace.png'),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        CustomExpansionTile(
                          title: 'Generelle Informationen',
                          textToTitle: generalInformation(),
                          bot: 10,
                          decoration: thickCyan(),
                        ),
                        CustomExpansionTile(
                            title: 'Benutzerkonto',
                            textToTitle: userAccount(),
                          bot: 10,
                            decoration: thickCyan(),
                        ),
                        CustomExpansionTile(
                          title: 'Mahlzeit erfassen',
                          textToTitle: recordMeal(),
                          bot: 10,
                          decoration: thickCyan(),
                        ),
                        CustomExpansionTile(
                          title: 'Symptome erfassen',
                          textToTitle: recordSymptoms(),
                          bot: 10,
                          decoration: thickCyan(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
