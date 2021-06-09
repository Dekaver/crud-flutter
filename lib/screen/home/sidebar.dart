import 'package:flutter/material.dart';
import 'package:homely/screen/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          'lib/src/resource/undercarriage-parts-icon.png'))),
              child: Stack(children: <Widget>[
                Positioned(
                    bottom: 13.0,
                    left: 75.0,
                    child: Text("Kalkulator Undercarriage",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500))),
              ])),
          Divider(),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.exit_to_app_outlined),
                Padding(
                    padding: EdgeInsets.only(left: 8.0), child: Text('Logout'))
              ],
            ),
            onTap: () async {
              // var res = await Network().getData('/api/logout');
              // var body = json.decode(res.body);
              // if (body['success']) {
              SharedPreferences localStorage = await SharedPreferences.getInstance();
              localStorage.remove('user');
              localStorage.remove('token');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginScreen()));
              // }
              // Navigator.push(
              //     context, MaterialPageRoute(
              //       builder: (context) => AboutPage()
              //       ));
            },
          ),
        ],
      ),
    );
  }
}
