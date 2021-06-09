import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homely/api/api.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List users;
  bool isLoading;

  Future<String> getData() async {
    setState(() {
      isLoading = true;
    });
    var res = await new Network().getData('/api/categories/user.php');
    users = json.decode(res.body);

    // await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
    return "Success!";
  }

  @override
  // ignore: must_call_super
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Table makeTable(user) => new Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          new TableRow(
            children: <Widget>[
              Text('Nama'),
              Container(
                height: 20,
                child: Text("email"),
              ),
            ],
          ),
          for (var i = 0; i < user['num']; i++)
            new TableRow(
              children: <Widget>[
                Text(user['result'][i]['nama']),
                Container(
                  height: 20,
                  child: Text(user['result'][i]['email'].toString()),
                ),
              ],
            ),
        ]);

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: users == null ? 0 : users.length,
            // itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Text(users[index]['nama'],
                    style: TextStyle(
                      fontSize: 12),
                  ),
                  Container(
                    height: 20,
                    child: Text(users[index]['email'].toString(),
                    style: TextStyle(
                      fontSize: 12
                    ),
                    ),
                  ),
                ],
              );
              // return makeTable(users[index]);
            },
          );
    //       Container(
    //   padding: EdgeInsets.all(20.0),
    //     child: Column(
    //       children: <Widget>[

    //       ])
    // );
  }
}
