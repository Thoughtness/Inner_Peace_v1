import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
// ignore: camel_case_types
class Infos extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
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
      ],
    ),
  );
}