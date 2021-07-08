import 'package:flutter/material.dart';
import 'dart:convert';

import '../providers/student_details.dart';
import 'package:http/http.dart' as http;
import './home_screen.dart';

class FormScreen extends StatefulWidget with ChangeNotifier {
  static const routeName = '/edit-product';

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> with ChangeNotifier {
  final _mobileNumberFocusNode = FocusNode();
  final _emailAddressFocusNode = FocusNode();
  final _currentLocationFocusNode = FocusNode();
  final _universityRollNumberFocusNode = FocusNode();
  final _collegeNameFocusNode = FocusNode();
  final _semesterFocusNode = FocusNode();

  final _descriptionFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _editedProduct = StudentData(
    id: null,
    name: '',
    mobileNumber: 0,
    emailAddress: '',
    currentLocation: '',
    universityRollNumber: 0,
    collegeName: '',
    semester: '',
    description: '',
  );

  @override
  void dispose() {
    _mobileNumberFocusNode.dispose();
    _emailAddressFocusNode.dispose();
    _currentLocationFocusNode.dispose();
    _universityRollNumberFocusNode.dispose();
    _collegeNameFocusNode.dispose();
    _semesterFocusNode.dispose();
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  Future<void> fetchAndSetProducts() async {
    List<StudentData> _items = [];
    const url = 'https://covidtastic-default-rtdb.firebaseio.com/students.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<StudentData> loadedDetails = [];
      extractedData.forEach((stdId, stdData) {
        loadedDetails.add(StudentData(
          id: stdId,
          name: stdData['name'],
          mobileNumber: stdData['mobileNumber'],
          emailAddress: stdData['emailAddress'],
          currentLocation: stdData['currentLocation'],
          universityRollNumber: stdData['universityRollNumber'],
          collegeName: stdData['collegeName'],
          semester: stdData['semester'],
          description: stdData['description'],
        ));
      });

      _items = loadedDetails;
      print(_items);
      notifyListeners();
      print(response);
    } catch (error) {
      throw (error);
    }
  }

  void _addProduct(StudentData product) {
    const url = 'https://covidtastic-default-rtdb.firebaseio.com/students.json';
    http.post(Uri.parse(url),
        body: json.encode({
          'name': product.name,
          'mobileNumber': product.mobileNumber,
          'emailAddress': product.emailAddress,
          'currentLocation': product.currentLocation,
          'universityRollNumber': product.universityRollNumber,
          'collegeName': product.collegeName,
          'semester': product.semester,
          'description': product.description,
        }));
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PLEASE FILL OUT THE FORM'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
              _addProduct(
                StudentData(
                  id: DateTime.now().toString(),
                  name: _editedProduct.name,
                  mobileNumber: _editedProduct.mobileNumber,
                  emailAddress: _editedProduct.emailAddress,
                  currentLocation: _editedProduct.currentLocation,
                  universityRollNumber: _editedProduct.universityRollNumber,
                  collegeName: _editedProduct.collegeName,
                  semester: _editedProduct.semester,
                  description: _editedProduct.description,
                ),
              );

              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'NAME'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_mobileNumberFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = StudentData(
                    id: null,
                    name: value,
                    mobileNumber: _editedProduct.mobileNumber,
                    emailAddress: _editedProduct.emailAddress,
                    currentLocation: _editedProduct.currentLocation,
                    universityRollNumber: _editedProduct.universityRollNumber,
                    collegeName: _editedProduct.collegeName,
                    semester: _editedProduct.semester,
                    description: _editedProduct.description,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'MOBILE NUMBER'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _emailAddressFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Mobile Number.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  if (value.length < 10) {
                    return 'Number is less than 10 digits';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = StudentData(
                    name: _editedProduct.name,
                    mobileNumber: double.parse(value!),
                    emailAddress: _editedProduct.emailAddress,
                    currentLocation: _editedProduct.currentLocation,
                    universityRollNumber: _editedProduct.universityRollNumber,
                    collegeName: _editedProduct.collegeName,
                    semester: _editedProduct.semester,
                    description: _editedProduct.description,
                    id: null,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'EMAIL ADDRESS'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(_currentLocationFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  if (!value.endsWith('@gmail.com')) {
                    return 'Please Enter a valid Email Address.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = StudentData(
                    id: null,
                    name: _editedProduct.name,
                    mobileNumber: _editedProduct.mobileNumber,
                    emailAddress: value,
                    currentLocation: _editedProduct.currentLocation,
                    universityRollNumber: _editedProduct.universityRollNumber,
                    collegeName: _editedProduct.collegeName,
                    semester: _editedProduct.semester,
                    description: _editedProduct.description,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CURRENT LOCATION'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(_universityRollNumberFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = StudentData(
                    id: null,
                    name: _editedProduct.name,
                    mobileNumber: _editedProduct.mobileNumber,
                    emailAddress: _editedProduct.emailAddress,
                    currentLocation: value,
                    universityRollNumber: _editedProduct.universityRollNumber,
                    collegeName: _editedProduct.collegeName,
                    semester: _editedProduct.semester,
                    description: _editedProduct.description,
                  );
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'UNIVERSITY ROLL NUMBER'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_collegeNameFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = StudentData(
                    id: null,
                    name: value,
                    mobileNumber: _editedProduct.mobileNumber,
                    emailAddress: _editedProduct.emailAddress,
                    currentLocation: _editedProduct.currentLocation,
                    universityRollNumber: double.parse(value!),
                    collegeName: _editedProduct.collegeName,
                    semester: _editedProduct.semester,
                    description: _editedProduct.description,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'COLLEGE NAME'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_semesterFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = StudentData(
                    id: null,
                    name: _editedProduct.name,
                    mobileNumber: _editedProduct.mobileNumber,
                    emailAddress: _editedProduct.emailAddress,
                    currentLocation: _editedProduct.currentLocation,
                    universityRollNumber: _editedProduct.universityRollNumber,
                    collegeName: value,
                    semester: _editedProduct.semester,
                    description: _editedProduct.description,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'SEMESTER'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = StudentData(
                    id: null,
                    name: _editedProduct.name,
                    mobileNumber: _editedProduct.mobileNumber,
                    emailAddress: _editedProduct.emailAddress,
                    currentLocation: _editedProduct.currentLocation,
                    universityRollNumber: _editedProduct.universityRollNumber,
                    collegeName: _editedProduct.collegeName,
                    semester: value,
                    description: _editedProduct.description,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'DESCRIPTION'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = StudentData(
                    name: _editedProduct.name,
                    mobileNumber: _editedProduct.mobileNumber,
                    emailAddress: _editedProduct.emailAddress,
                    currentLocation: _editedProduct.currentLocation,
                    universityRollNumber: _editedProduct.universityRollNumber,
                    collegeName: _editedProduct.collegeName,
                    semester: _editedProduct.semester,
                    description: value,
                    id: null,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
