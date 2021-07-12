import 'package:flutter/material.dart';

// ignore: camel_case_types
class customRow extends StatelessWidget {
  final textController;
  final String description;
  final String title;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 0.0;

  customRow({
    required this.title,
    required this.description,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    double width = 10.0;
    return Container(
      padding: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      child: Row(
        children: <Widget>[
          //SizedBox(width: width),
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5.0) //
                    ),
              ),
              //height: 49,
              child: ListTile(
                title: Text(title),
              ),
            ),
          ),
          SizedBox(width: width),
          Flexible(
            flex: 3,
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
          ),
          //SizedBox(width: width),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class customButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 0.0;

  customButton({
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

// ignore: camel_case_types
class customSlider extends StatefulWidget {
  final String title;
  final String good;
  final String bad;

  customSlider({
    required this.title,
    required this.good,
    required this.bad,
  });

  @override
  _customSlider createState() {
    return _customSlider(title: title, good: good, bad: bad);
  }
}

// ignore: camel_case_types
class _customSlider extends State<customSlider> {
  String title = "";
  double height = 15.0;
  double width = 10.0;
  String good;
  String bad;

  _customSlider({
    required this.title,
    required this.good,
    required this.bad,
  });
  double value = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height),
          Container(
            height: 110,
            decoration: myBoxDecoration(),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent,
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: width),
                      new Text(
                        title,
                        style: TextStyle(
                          backgroundColor: Colors.cyanAccent,
                          height: 1.5,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Slider.adaptive(
                        value: value,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        activeColor: Colors.cyanAccent,
                        onChanged: (changedValue) {
                          setState(() => value = changedValue);
                          print(changedValue);
                        },
                        label: "$value",
                      ),
                    ),
                  ],
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: width),
                    new Text(
                      good,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        height: 0.5,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    new Text(
                      bad,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        height: 0.5,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: width),
                  ],
                ),
              ],
            ),
          ),
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
