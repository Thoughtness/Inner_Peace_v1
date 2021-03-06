import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/MyUser.dart';
import 'package:inner_peace_v1/Pages/MainMenu.dart';
import 'package:flutter/widgets.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';

import 'CreateAccount.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  MyUser _myUser = MyUser();

  void _saveUserId(int userId) {
    _myUser.myUserId = userId;
  }

  TextEditingController username = TextEditingController();
  bool falseUser = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: AssetImage('assets/Inner_Peace.png'),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Inner Peace', style: loginWindowTitle(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextField(
                      controller: username,
                      decoration: loginWindow('Benutzername'),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: CustomButton(
                          text: 'Einloggen',
                          onClick: () async {
                            var validUser = await checkLogin(username.text);
                            if (validUser != null) {
                              _saveUserId(validUser[0]['userID']);
                              var warnings = await filteredAverageSymptomsListWithAmount(
                                  'red');
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MainMenu(warnings: warnings),
                              ));
                            } else {
                              setState(() {
                                falseUser = true;
                              });
                            }
                          }
                      )
                  ),
                  Container(
                    child: TextButton(
                      child: Text('Benutzerkonto erstellen',
                        style: myTextStyleMedium(),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateAccount(),
                        ));
                      },
                    ),
                  ),
                  Visibility(
                    visible: falseUser,
                    child: Container(
                      decoration: thinGrey(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Benutzer existiert nicht',
                          style: myTextStyleSmallRed(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}