import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/Text.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';

// ignore: camel_case_types
class Infos extends StatelessWidget{

  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.teal[100],
        endDrawer: Menu(),
        appBar: AppBar(
          title: Text('Infos',
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
                        InfoEntry(
                          title: 'Diabetes',
                          explanation: diabetesExplanation(),
                          titleCauses: 'Ursachen',
                          causes: diabetesCauses(),
                          titlePrevent: 'Vorbeugen',
                          prevent: diabetesPrevent(),
                          titleCure: 'Heilung',
                          cure: diabetesCure(),
                          source: diabetesSource(),
                        ),
                        InfoEntry(
                          title: 'Magersucht',
                          explanation: anorexiaExlanation(),
                          titleCauses: 'Ursachen',
                          causes: anorexiaCauses(),
                          titlePrevent: 'Vorbeugen',
                          prevent: anorexiaPrevent(),
                          titleCure: 'Heilung',
                          cure: anorexiaCure(),
                          source: anorexiaSource(),
                        ),
                        InfoEntry(
                          title: 'Adipositas',
                          explanation: adipositasExlanation(),
                          titleCauses: 'Ursachen',
                          causes: adipositasCauses(),
                          titlePrevent: 'Vorbeugen',
                          prevent: adipositasPrevent(),
                          titleCure: 'Heilung',
                          cure: adipositasCure(),
                          source: adipositasSource(),
                        ),
                        InfoEntry(
                          title: 'Reizmagen',
                          explanation: irrStomachExlanation(),
                          titleCauses: 'Ursachen',
                          causes: irrStomachCauses(),
                          titlePrevent: 'Vorbeugen',
                          prevent: irrStomachPrevent(),
                          titleCure: 'Heilung',
                          cure: irrStomachCure(),
                          source: irrStomachSource(),
                        ),
                        InfoEntry(
                          title: 'Reizdarm',
                          explanation: irrBowelExlanation(),
                          titleCauses: 'Ursachen',
                          causes: irrBowelCauses(),
                          titlePrevent: 'Vorbeugen',
                          prevent: irrBowelPrevent(),
                          titleCure: 'Heilung',
                          cure: irrBowelCure(),
                          source: irrBowelSource(),
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
