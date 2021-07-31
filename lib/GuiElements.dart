import 'package:flutter/material.dart';

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
      padding: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
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

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    color: Colors.teal[50],
    border: Border.all(width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  );
}

BoxDecoration myInnerBoxDecoration() {
  return BoxDecoration(
    color: Colors.cyanAccent,
    border: Border.all(width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

TextStyle myAppBarTextStyle(){
  return TextStyle(
    color: Colors.black,
  );
}

TextStyle myTitleCyanAccentTextStyle(){
  return TextStyle(
    backgroundColor: Colors.cyanAccent,
    height: 1.5,
    fontSize: 25,
    color: Colors.black,
  );
}

TextStyle myTextStyle(){
  return TextStyle(
    fontSize: 14,
    color: Colors.black,
  );
}

TextStyle mySliderTextStyle(){
  return TextStyle(
    height: 0.5,
    fontSize: 18,
  );
}


