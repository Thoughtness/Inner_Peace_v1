import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
// ignore: camel_case_types
class Infos extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.teal[100],
    endDrawer: menu(),
    appBar: AppBar(
      title: Text('Infos',
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