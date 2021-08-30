import 'package:flutter/material.dart';
import 'package:keepnote/database/database_helper.dart';
import 'package:keepnote/models/user.dart';
import 'package:keepnote/views/commons/animation/fadeanimation.dart';
import 'package:keepnote/views/commons/utils/custom_toast.dart';
import 'package:keepnote/views/constants/constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  DatabaseHelper _db;
  bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _db = DatabaseHelper();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: !isLoading?
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blue[900],
              Colors.blue[700],
              Colors.blueAccent[400]
            ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                        1.3,
                        Text(
                          "Welcome \nput your information",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          FadeAnimation(
                              1.6,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                          Color.fromRGBO(102, 153, 204, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                            hintText: "Email Address",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          FadeAnimation(
                              1.6,
                              GestureDetector(
                                onTap: () async {
                                  if (_emailController.text == "") {
                                    CustomToast.toast('Please enter the title');
                                  } else if (_passwordController.text == "") {
                                    CustomToast.toast('Please enter the content');
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    UserModel user = UserModel(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    var isAdded = await _db.addUser(user);

                                    if (isAdded != null) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      CustomToast.toast(
                                          'Sign up is Worked successfully');
                                      Navigator.pop(context, true);
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      CustomToast.toast(
                                          'Sign up can not be added right now');
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blueAccent[400]),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          FadeAnimation(
                              1.7,
                              Text(
                                "Have An Account then",
                                style: TextStyle(color: Colors.grey),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                              1.9,
                              Container(
                                width: 60,
                                height: 25,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueAccent[400]),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ):
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(qColorPrimary),
          ),
        ),
      ),
    );
  }
}
