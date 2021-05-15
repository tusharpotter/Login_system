import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginStates();
  }
}

class LoginStates extends State<Login> {
  bool _isloggedin = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  User _user;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isloggedin
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/back.jpg'), fit: BoxFit.cover)),
              child: new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      Text(
                        'Sign In',
                        style: GoogleFonts.caveat(
                          textStyle: TextStyle(
                              color: Colors.blue[300],
                              fontSize: 60.0,
                              fontWeight: FontWeight.w700),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Image(
                        image: AssetImage('assets/images.png'),
                        height: 220.0,
                        width: 220.0,
                        alignment: Alignment.center,
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(11.0),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border:
                                    Border.all(width: 1.7, color: Colors.blue),
                                shape: BoxShape.circle),
                            child: Image.asset('assets/faceboo.png',
                                height: 35.0, width: 35.0),
                          ),

                          SizedBox(width: 20.0),
                          // ignore: deprecated_member_use
                          SizedBox(
                            height: 45.0,
                            width: 240.0,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: () async {
                                await _handlelogin();
                              },
                              child: Text(
                                'Sign In With Facebook',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                              color: Colors.blue[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border:
                                    Border.all(width: 1.7, color: Colors.blue),
                                shape: BoxShape.circle),
                            child: Image.asset('assets/google.png',
                                height: 45.0, width: 45.0),
                          ),
                          SizedBox(width: 20.0),
                          // ignore: deprecated_member_use
                          SizedBox(
                            height: 45.0,
                            width: 220,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: () async {
                                await _loginwithgoogle();
                              },
                              child: Text(
                                'Sign In With Google',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                              color: Colors.blue[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          SizedBox(width: 18.0),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : _user != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/new.jpg'),
                          fit: BoxFit.cover)),
                  child: new BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Center(
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 60.0),
                          CircleAvatar(
                            radius: 60.0,
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(_user.photoURL),
                                fit: BoxFit.cover,
                              ),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          Text(
                            _user.displayName,
                            style: GoogleFonts.caveat(
                                textStyle: TextStyle(
                              color: Colors.red[200],
                              fontSize: 45.0,
                              fontWeight: FontWeight.w400,
                            )),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            _user.email,
                            style: GoogleFonts.merienda(
                                textStyle: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 20.0,
                                    letterSpacing: 1.5)),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 130, right: 130.0, top: 35.0),
                            // ignore: deprecated_member_use
                            child: RaisedButton.icon(
                              color: Colors.green[200],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () async {
                                await _showAlertDialog('Confirmation',
                                    'Are you sure want to log out ?', () async {
                                  Navigator.of(context).pop();
                                  await _signoutwithfb();
                                });
                              },
                              label: Text(
                                'SignOut',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              icon: Icon(Icons.logout),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/new.jpg'),
                          fit: BoxFit.cover)),
                  child: new BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Center(
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 60.0),
                          CircleAvatar(
                            radius: 60.0,
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(_userObj.photoUrl),
                              ),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          Text(
                            _userObj.displayName,
                            style: GoogleFonts.caveat(
                                textStyle: TextStyle(
                              color: Colors.red[200],
                              fontSize: 45.0,
                              fontWeight: FontWeight.w400,
                            )),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            _userObj.email,
                            style: GoogleFonts.merienda(
                                textStyle: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 20.0,
                                    letterSpacing: 1.5)),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 130, right: 130.0, top: 35.0),
                            // ignore: deprecated_member_use
                            child: RaisedButton.icon(
                              color: Colors.green[200],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () async {
                                await _showAlertDialog('Confirmation',
                                    'Are you sure want to log out ?', () async {
                                  _googleSignIn.signOut().then((value) {
                                    setState(() {
                                      _isloggedin = false;
                                    });
                                    Navigator.of(context).pop();
                                  }).catchError((e) {});
                                });
                              },
                              label: Text(
                                'SignOut',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              icon: Icon(Icons.logout),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Future _showAlertDialog(String title, String message, Function func) async {
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      backgroundColor: Colors.blue[200],
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
            onPressed: func,
            child: Text('Logout',
                textScaleFactor: 1.5, style: TextStyle(color: Colors.black)))
      ],
    );
    await showDialog(context: context, builder: (_) => alertDialog);
  }

  Future _handlelogin() async {
    FacebookLoginResult _result = await _facebookLogin.logIn(["email"]);
    switch (_result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("cancelled by user");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        await _loginwithfacebook(_result);
        break;
    }
  }

  Future _loginwithfacebook(FacebookLoginResult _result) async {
    FacebookAccessToken _accesssToken = _result.accessToken;
    AuthCredential _credential =
        FacebookAuthProvider.credential(_accesssToken.token);
    var a = await _auth.signInWithCredential(_credential);
    setState(() {
      _isloggedin = true;
      _user = a.user;
    });
  }

  Future _signoutwithfb() async {
    await _auth.signOut().then((value) {
      setState(() {
        _facebookLogin.logOut();
        _isloggedin = false;
        _user = null;
      });
    });
  }

  Future _loginwithgoogle() async {
    await _googleSignIn.signIn().then((userData) {
      setState(() {
        _isloggedin = true;
        _userObj = userData;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
