import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homely/api/api.dart';
import 'package:homely/screen/auth/register.dart';
import 'package:homely/screen/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController usernameText = TextEditingController();
    TextEditingController passwordText = TextEditingController();
    return Scaffold(
        body: Center(
            child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOGIN",
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
                        hintText: "Your username",
                      ),
                      controller: usernameText,
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        
                          icon: Icon(Icons.lock, color: Colors.black87),
                          hintText: "Password",
                          suffixIcon:
                              Icon(Icons.visibility, color: Colors.black87)),
                      controller: passwordText,
                      onChanged: (value) {},
                    ),
                    TextButton(
                      child: Text(
                        "LOGIN",
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
                        _login(context, usernameText.text, passwordText.text);
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don’t have an Account ? ',
                          style: TextStyle(color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
                                Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => RegisterScreen())); 
                                
                          },
                          child: Text(
                            "Sign Up",
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

  void _login(context, username, password) async {
    Map data = {'username': username, 'password': password};

    var res = await Network().authData(data, '/api/auth/login.php');
    var body = json.decode(res.body);
    if (body['info'] == "success") {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['result'][0]['nama']));
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(body['result'][0]['nama'].toString()));
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
