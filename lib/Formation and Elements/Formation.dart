import 'package:flutter/material.dart';
BoxDecoration thinSquare() {
  return BoxDecoration(
    border: Border.all(width: 1.0),
  );
}

BoxDecoration thickGrey() {
  return BoxDecoration(
    color: Colors.grey[50],
    border: Border.all(width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  );
}

BoxDecoration thickDarkGrey() {
  return BoxDecoration(
    color: Colors.grey[200],
    border: Border.all(width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  );
}

BoxDecoration thinGrey() {
  return BoxDecoration(
    color: Colors.grey[50],
    border: Border.all(width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

BoxDecoration noSquareGrey() {
  return BoxDecoration(
    color: Colors.grey[50],
  );
}

BoxDecoration topSquareGrey() {
  return BoxDecoration(
    color: Colors.grey[50],
    border: Border(
      top: BorderSide(width: 1.0),
    ),
  );
}

BoxDecoration thickCyan() {
  return BoxDecoration(
    color: Colors.cyanAccent,
    border: Border.all(width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  );
}

BoxDecoration thinCyan() {
  return BoxDecoration(
    color: Colors.cyanAccent,
    border: Border.all(width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

BoxDecoration thinRed() {
  return BoxDecoration(
    color: Colors.red,
    border: Border.all(width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

BoxDecoration ingredientBar(int index, List<double> amountList) {
  return BoxDecoration(
    color: Colors.blue,
    border: Border.all(width: borderRadius(index, amountList)),
    borderRadius: BorderRadius.all(
        Radius.circular(20.0)),
  );
}

BoxDecoration symptomsBar(Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(
        Radius.circular(20.0)),
  );
}

buttonStyle(){
  return TextButton.styleFrom(
    side: BorderSide(width: 2.0, color: Colors.black),
    backgroundColor: Colors.cyanAccent,
    minimumSize: Size(0, 45),
    primary: Colors.black,
  );
}

InputDecoration loginWindow(String text){
  return InputDecoration(
    border: OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
    labelText: text,
  );
}

InputDecoration customInputDecoration(String description){
  return InputDecoration(
    fillColor: Colors.grey[50],
    filled: true,
    border: OutlineInputBorder(),
    hintText: description,
  );
}

TextStyle myAppBarTextStyle(){
  return TextStyle(
    color: Colors.black,
  );
}

TextStyle loginWindowTitle(){
  return TextStyle(
    fontSize: 40,
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
TextStyle mySliderTextStyle(){
  return TextStyle(
      height: 0.5,
      fontSize: 18,
      color: Colors.black
  );
}

TextStyle myTextStyleMedium(){
  return TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
}

TextStyle myTextStyleMediumThick(){
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.black,
  );
}

TextStyle myTextStyleSmall(){
  return TextStyle(
    fontSize: 14,
    color: Colors.black,
  );
}

TextStyle myTextStyleSmallRed(){
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.red,
  );
}

Theme datePicker(Widget? picker){
  return Theme(
    data: ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: Colors.black,
        onPrimary: Colors.white,
        surface: Colors.cyanAccent,
        onSurface: Colors.black,
      ),
      dialogBackgroundColor: Colors.grey[50],
    ),
    child: picker!,
  );
}

//damit wenn die Menge '0' beträgt kein schwarzer Strich entsteht
borderRadius(int index, List<double> amountList) {
  if (amountList[index].toInt() == 0) {
    return 0.0;
  }
  return 1.0;
}