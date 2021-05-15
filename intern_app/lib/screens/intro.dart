import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intern_app/screens/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            PageTransition(
                child: Login(), type: PageTransitionType.rightToLeft)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/backto.jpg'), fit: BoxFit.cover)),
        margin: EdgeInsets.only(top: 23.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(height: 200.0),
            Text(
              'Profilo',
              style: GoogleFonts.dancingScript(
                  textStyle: TextStyle(
                shadows: [
                  Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0))
                ],
                color: Colors.red[300],
                fontSize: 100.0,
                fontWeight: FontWeight.w500,
              )),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 80.0),
            SizedBox(
              height: 55.0,
              width: 55.0,
              child: CircularProgressIndicator(
                backgroundColor: Colors.red[300],
                strokeWidth: 5.0,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
