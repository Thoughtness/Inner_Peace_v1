import 'package:flutter/material.dart';

BoxDecoration thickTeal() {
  return BoxDecoration(
    color: Colors.teal[50],
    border: Border.all(width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  );
}

BoxDecoration thinTeal() {
  return BoxDecoration(
    color: Colors.teal[50],
    border: Border.all(width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

BoxDecoration noTeal() {
  return BoxDecoration(
    color: Colors.teal[50],
    //border: Border.all(width: 1.0),
    //borderRadius: BorderRadius.all(Radius.circular(5.0)),
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

BoxDecoration symptomsBar(int index, List<double> amountList) {
  return BoxDecoration(
    color: Colors.blue,
    border: Border.all(width: borderRadius(index, amountList)),
    borderRadius: BorderRadius.all(
        Radius.circular(20.0)),
  );
}
//damit wenn die Menge "0" beträgt kein schwarzer Strich entsteht
borderRadius(int index, List<double> amountList) {
  if (amountList[index].toInt() == 0) {
    return 0.0;
  }
  return 1.0;
}

BoxDecoration myIngredientBoxDecoration() {
  return BoxDecoration(
    color: Colors.cyanAccent,
    border: Border.all(width: 1.0),
    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
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
TextStyle mySliderTextStyle(){
  return TextStyle(
      height: 0.5,
      fontSize: 18,
      color: Colors.black
  );
}

TextStyle myTextStyleSmall(){
  return TextStyle(
    fontSize: 14,
    color: Colors.black,
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
      dialogBackgroundColor: Colors.teal[50],
    ),
    child: picker!,
  );
}