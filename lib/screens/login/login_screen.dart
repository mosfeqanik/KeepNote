import 'package:flutter/material.dart';
import 'package:keepnote/screens/commons/custombutton.dart';
import 'package:keepnote/screens/commons/input_field.dart';
import 'package:keepnote/screens/home/home_page.dart';
import 'package:keepnote/utils/custom_toast.dart';
import 'package:keepnote/utils/share_pref.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;

  @override
  void initState() {
    super.initState();
    setPref();
  }

  void setPref() async {
    await Prefs.loadPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Icon(
                  Icons.textsms,
                  size: 120,
                  color: Colors.deepPurple[900],
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Hero(
              tag: 'HeroTitle',
              child: Text(
                'Converse',
                style: TextStyle(
                    color: Colors.deepPurple[900],
                    fontFamily: 'Poppins',
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            InputFiled(
              hintText: 'Enter e-mail',
              leading: Icons.mail,
              keyboard: TextInputType.emailAddress,
              obscure: false,
              userTyped: (value) {
                email = value;
              },
            ),
            InputFiled(
              hintText: 'Password',
              leading: Icons.lock,
              keyboard: TextInputType.visiblePassword,
              obscure: true,
              userTyped: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: 24.0,
            ),
            CustomButton(
              onpress: () async {
                if (password != null && email != null) {
                  if (email == 'test@mail.com' && password == '1234') {
                    Prefs.setBool(Prefs.IS_LOGGED_IN, true);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                  }
                } else {
                  CustomToast.toast('Credential Error');
                }
              },
              text: 'sign in',
              accentColor: Colors.white,
              mainColor: Colors.deepPurple,
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
