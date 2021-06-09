import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homely/api/api.dart';
import 'package:homely/screen/auth/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailText = TextEditingController();
    TextEditingController passwordText = TextEditingController();
    TextEditingController usernameText = TextEditingController();
    TextEditingController passwordConfirmationText = TextEditingController();
    return Scaffold(
        body: Center(
            child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Register",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // SvgPicture.asset(
                    //   "assets/icons/login.svg",
                    //   height: size.height * 0.35,
                    // ),
                    SizedBox(height: size.height * 0.03),

                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.person, color: Colors.black87),
                          hintText: "username",
                          ),
                      controller: usernameText,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.person, color: Colors.black87),
                        hintText: "Your Email",
                      ),
                      controller: emailText,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.black87),
                          hintText: "Password",
                          suffixIcon:
                              Icon(Icons.visibility, color: Colors.black87)),
                      controller: passwordText,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.black87),
                          hintText: "Password Confirmation",
                          suffixIcon:
                              Icon(Icons.visibility, color: Colors.black87)),
                      controller: passwordConfirmationText,
                    ),
                    TextButton(
                      child: Text(
                        "REGISTER",
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: BorderSide(color: Colors.black)))),
                      onPressed: () {
                        _register(context,  usernameText.text, emailText.text, passwordText.text);
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an Account ?',
                          style: TextStyle(color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ))));
  }
  void _register(context, username, email, password) async {
    Map data = {'username': username, 'email': email, 'password': password};

    var res = await Network().authData(data, '/api/auth/register.php');
    // print(json.decode(res.body));
    var body = json.decode(res.body);
    if (body['info'] == "success") {
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('token', json.encode(body['token']));
      // localStorage.setString('user', json.encode(body['result'][0]));
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(body.toString()));
        },
      );
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     new MaterialPageRoute(builder: (context) => HomeScreen()),
      //     (Route<dynamic> route) => false);
    } else if (body['info'] == 'error') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(body.toString()));
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text("error"));
        },
      );
    }
  }
}
