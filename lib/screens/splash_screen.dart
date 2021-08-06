import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keepnote/utils/share_pref.dart';

import 'home/home_page.dart';
import 'login/login_screen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoggedIn = true;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () => {setPref()});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  void setPref() async {
    await Prefs.loadPref();
    bool isLoggedIn;
    isLoggedIn = Prefs.getBool(Prefs.IS_LOGGED_IN,def:false);
    if(isLoggedIn){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
    }else{
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Notebook',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: '365',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              height: 2,
              child: LinearProgressIndicator(
                backgroundColor: Colors.blue,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
