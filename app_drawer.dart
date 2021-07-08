import 'dart:io';

import 'package:flutter/material.dart';
import '../screens/form_screen.dart';
import '../screens/login_screen.dart';
import '../screens/student_data.dart';
import '../screens/home_screen.dart';

// import '../screens/orders_screen.dart';
// import '../screens/user_products_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              'CovidTastic',
              style: TextStyle(fontFamily: 'Trueno'),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.next_plan),
                onPressed: () {
                  var coun = 0;
                  setState(() {
                    count += 1;
                    coun = count;
                  });
                  print(count);
                },
              ),
            ],
            automaticallyImplyLeading: false,
          ),
          Divider(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('HOME'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.file_copy),
            title: Text('FORM'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(FormScreen.routeName);
            },
          ),
          Divider(),
          (count % 2 == 0)
              ? ListTile(
                  leading: Icon(Icons.bar_chart),
                  title: Text('STUDENTS DATA'),
                  onTap: () {
                    Navigator.of(context).pushNamed(StudentDetails.routeName);
                  },
                )
              : Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('SETTINGS'),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('LOG OUT'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('EXIT'),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}
