import 'package:flutter/material.dart';
import 'package:homely/screen/crud/users/user_view.dart';
import 'package:homely/screen/home/sidebar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Sidebar(),
      ),
      appBar: AppBar(
        title: Text("Asrama"),
      ),
      body: ListView(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserScreen()));
              },
              child: Text('User'))
        ],
      ),
    );
  }
}
