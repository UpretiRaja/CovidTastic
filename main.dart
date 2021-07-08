import 'package:covidtastic/constants.dart';
import 'screens/home_screen.dart';
import 'package:flutter/material.dart';
import './screens/more_home.dart';
import './screens/login_screen.dart';
import 'screens/form_screen.dart';
import './screens/student_data.dart';
//import './screens/log_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CovidTastic',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        MoreHome.routeName: (ctx) => MoreHome(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        FormScreen.routeName: (ctx) => FormScreen(),
        StudentDetails.routeName: (ctx) => StudentDetails(),
        //LogScreen.routeName: (ctx) => LogScreen(),
      },
    );
  }
}
