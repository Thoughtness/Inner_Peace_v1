import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/Functions.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';
import 'package:flutter/widgets.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';

import 'LoginPage.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  TextEditingController username = TextEditingController();
  var notVisibleOnStart = false;
  var freeUser = false;

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
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: CustomButton(
                          text: 'Benutzerkonto erstellen',
                          onClick: () async {
                            freeUser = await ifAvailableSave(username.text);
                            notVisibleOnStart = true;
                            setState(() {});
                          }
                      )
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: CustomButton(
                          text: 'Zur??ck zum Login',
                          onClick: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                          }
                      )
                  ),
                  Visibility(
                    visible: notVisibleOnStart,
                    child: Container(
                      height: 46,
                      width: double.infinity,
                      decoration: thinGrey(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(freeOrUsed(freeUser),
                            style: myTextStyleSmallRed(),
                          ),
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