import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class StudentDetails extends StatefulWidget {
  static const routeName = '/student-details';
  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  var _isInit = true;
  @override
  void initState() {
    super.initState();
  }

  var count = 0;
  void _refresh() {
    var finalCount;
    setState(() {
      count += 1;
      finalCount = count;
    });
    print(finalCount);
  }

  var _expand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STUDENT DETAILS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _refresh();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (count == 0)
            Container()
          else
            Card(
              elevation: 10,
              child: ListTile(
                title: Text(
                  'RAM PRASAD BHANDARI',
                  style: TextStyle(fontFamily: 'Trueno'),
                ),
                subtitle: Text(
                  'Roll Number: 12345',
                  style: TextStyle(fontFamily: 'Trueno'),
                ),
                trailing: IconButton(
                    icon: _expand
                        ? Icon(Icons.expand_less)
                        : Icon(
                            Icons.expand_more,
                          ),
                    onPressed: () {
                      setState(() {
                        _expand = !_expand;
                      });
                    }),
              ),
            ),
        ],
      ),
    );
  }
}
