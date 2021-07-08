import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();
  final passwordFocusNode = FocusNode();

  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildLoginForm(context))));
  }
}

_buildLoginForm(ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
    child: ListView(
      children: [
        SizedBox(height: 75.0),
        Container(
          height: 125.0,
          width: 200.0,
          child: Stack(
            children: [
              Text('Hello',
                  style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
              Positioned(
                  top: 50.0,
                  child: Text('There',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0))),
              Positioned(
                  top: 97.0,
                  left: 175.0,
                  child: Container(
                      height: 10.0,
                      width: 10.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00AF19),
                      )))
            ],
          ),
        ),
        SizedBox(height: 25.0),
        TextFormField(
            decoration: InputDecoration(
              labelText: 'EMAIL',
              labelStyle: TextStyle(
                  fontFamily: 'Trueno',
                  fontSize: 12.0,
                  color: Colors.grey.withOpacity(0.5)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF00AF19),
                ),
              ),
            ),
            onChanged: (value) {
              email = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a value';
              }
              if (value != 'teacher@gmail.com' ||
                  value != 'student@gmail.com') {
                return 'Please register your email via ADMIN';
              }
            }),
        TextFormField(
            decoration: InputDecoration(
              labelText: 'PASSWORD',
              labelStyle: TextStyle(
                  fontFamily: 'Trueno',
                  fontSize: 12.0,
                  color: Colors.grey.withOpacity(0.5)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF00AF19)),
              ),
            ),
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Password is required' : null),
        SizedBox(height: 5.0),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => ResetPassword()));
          },
          child: Container(
            alignment: Alignment(1.0, 0.0),
            padding: EdgeInsets.only(top: 15.0, left: 20.0),
            child: InkWell(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                    color: Color(0xFF00AF19),
                    fontFamily: 'Trueno',
                    fontSize: 11.0,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
        ),
        SizedBox(height: 50.0),
        GestureDetector(
          onTap: () {
            // var formKey = new GlobalKey<FormState>();
            // final isValid = formKey.currentState!.validate();
            // if (!isValid) {
            //   return;
            // }
            Navigator.of(ctx).pushNamed(HomeScreen.routeName);
          },
          child: Container(
            height: 50.0,
            child: Material(
              borderRadius: BorderRadius.circular(25.0),
              shadowColor: Colors.greenAccent,
              color: Color(0xFF00AF19),
              elevation: 7.0,
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white, fontFamily: 'Trueno'),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

validateEmail(String value) {}

String? email;
String? password;
