import 'package:employeemanagementapp/src/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:employeemanagementapp/src/ui/formadd/form_add_screen.dart';
import 'package:employeemanagementapp/src/ui/home/home_screen.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final profile = Profile(first_name: 'Vikas',
      last_name: 'Sharma',
      designation: 'Software engineer',
      department: 'Software',
      email: 'vikas@pacefin.in',
      contact_number: 9876543210,
      dob: "01/01/1998",
      date_of_joining: "01/01/2022"
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.orangeAccent),
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text(
            "Employee Management System",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                var result = await Navigator.push(
                  _scaffoldState.currentContext!,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return FormAddScreen(
                        profile: profile); // Pass the profile parameter
                  }),
                );
                if (result != null) {
                  setState(() {});
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: HomeScreen(),
      ),
    );
  }
}
