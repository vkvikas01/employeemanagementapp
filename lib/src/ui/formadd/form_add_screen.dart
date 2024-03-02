import 'package:flutter/material.dart';
import 'package:employeemanagementapp/src/api/api_service.dart';
import 'package:employeemanagementapp/src/model/profile.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
 final Profile profile;

  FormAddScreen({required this.profile});

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class Department {
  const Department(this.name, this.id);
  final String name;
  final int id;
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldFirstNameValid = true;
  bool _isFieldLastNameValid = true;
  bool _isFieldDesignationValid = true;
  bool _isFieldDepartmentValid = true;
  bool _isFieldDateOfBirthValid = true;
  bool _isFieldDateOfJoiningValid = true;
  bool _isFieldEmailValid = true;
  bool _isFieldContactValid = true;

  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerDesignation = TextEditingController();
  TextEditingController _controllerDepartment = TextEditingController();
  TextEditingController _controllerDateOfBirth = TextEditingController();
  TextEditingController _controllerDateOfJoining = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerContact = TextEditingController();
  List<Department> depts = [
    const Department('Advertisement', 1),
    const Department('Engineering', 2),
    const Department('Accounts', 3)
  ];
  Department selectedDepartment = const Department('Advertisement', 1);

  @override
  void initState() {
    if (widget.profile != null) {
      _isFieldDepartmentValid = true;
      _isFieldDateOfBirthValid = true;
      _isFieldDateOfJoiningValid = true;
      _isFieldDesignationValid = true;
      _isFieldFirstNameValid = true;
      _isFieldLastNameValid = true;
      _controllerFirstName.text = widget.profile.first_name;
      _controllerLastName.text = widget.profile.last_name;
      _controllerDesignation.text = widget.profile.designation;
      print(widget.profile);
      selectedDepartment = depts
          .where((element) => element.name == widget.profile.department)
          .first;
      _controllerDateOfBirth.text = widget.profile.dob;
      _controllerDateOfJoining.text = widget.profile.date_of_joining;
      _isFieldEmailValid = true;
      _controllerEmail.text = widget.profile.email;
      _isFieldContactValid = true;
      _controllerContact.text = widget.profile.contact_number.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.profile == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldFirstName(),
                _buildTextFieldLastName(),
                _buildTextFieldEmail(),
                _buildTextFieldContact(),
                _buildTextFieldDesignation(),
                _buildTextFieldDepartment(),
                _buildTextFieldDateOfBirth(),
                _buildTextFieldDateOfJoining(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    child: Text(
                      widget.profile == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      // Submit logic
                    },
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldFirstName() {
    return TextField(
      controller: _controllerFirstName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "First name",
        errorText: _isFieldFirstNameValid ? null : "First name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldFirstNameValid) {
          setState(() => _isFieldFirstNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldLastName() {
  return TextField(
    controller: _controllerLastName,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: "Last name",
      errorText: _isFieldLastNameValid ? null : "Last name is required",
    ),
    onChanged: (value) {
      bool isFieldValid = value.trim().isNotEmpty;
      if (isFieldValid != _isFieldLastNameValid) {
        setState(() => _isFieldLastNameValid = isFieldValid);
      }
    },
  );
}

Widget _buildTextFieldEmail() {
  return TextField(
    controller: _controllerEmail,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: "Email",
      errorText: _isFieldEmailValid ? null : "Email is required",
    ),
    onChanged: (value) {
      bool isFieldValid = value.trim().isNotEmpty;
      if (isFieldValid != _isFieldEmailValid) {
        setState(() => _isFieldEmailValid = isFieldValid);
      }
    },
  );
}

Widget _buildTextFieldContact() {
  return TextField(
    controller: _controllerContact,
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
      labelText: "Contact",
      errorText: _isFieldContactValid ? null : "Contact is required",
    ),
    onChanged: (value) {
      bool isFieldValid = value.trim().isNotEmpty;
      if (isFieldValid != _isFieldContactValid) {
        setState(() => _isFieldContactValid = isFieldValid);
      }
    },
  );
}

Widget _buildTextFieldDesignation() {
  return TextField(
    controller: _controllerDesignation,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: "Designation",
      errorText: _isFieldDesignationValid ? null : "Designation is required",
    ),
    onChanged: (value) {
      bool isFieldValid = value.trim().isNotEmpty;
      if (isFieldValid != _isFieldDesignationValid) {
        setState(() => _isFieldDesignationValid = isFieldValid);
      }
    },
  );
}

Widget _buildTextFieldDepartment() {
  return DropdownButtonFormField<Department>(
    value: selectedDepartment,
    items: depts.map((Department dept) {
      return DropdownMenuItem<Department>(
        value: dept,
        child: Text(dept.name),
      );
    }).toList(),
    onChanged: (Department? value) {
      setState(() {
        selectedDepartment = value!;
      });
    },
    decoration: InputDecoration(
      labelText: "Department",
      errorText: _isFieldDepartmentValid ? null : "Department is required",
    ),
  );
}

Widget _buildTextFieldDateOfBirth() {
  return TextField(
    controller: _controllerDateOfBirth,
    keyboardType: TextInputType.datetime,
    decoration: InputDecoration(
      labelText: "Date of Birth",
      errorText: _isFieldDateOfBirthValid ? null : "Date of Birth is required",
    ),
    onChanged: (value) {
      bool isFieldValid = value.trim().isNotEmpty;
      if (isFieldValid != _isFieldDateOfBirthValid) {
        setState(() => _isFieldDateOfBirthValid = isFieldValid);
      }
    },
  );
}

Widget _buildTextFieldDateOfJoining() {
  return TextField(
    controller: _controllerDateOfJoining,
    keyboardType: TextInputType.datetime,
    decoration: InputDecoration(
      labelText: "Date of Joining",
      errorText: _isFieldDateOfJoiningValid ? null : "Date of Joining is required",
    ),
    onChanged: (value) {
      bool isFieldValid = value.trim().isNotEmpty;
      if (isFieldValid != _isFieldDateOfJoiningValid) {
        setState(() => _isFieldDateOfJoiningValid = isFieldValid);
      }
    },
  );
}

  // Implement other text field widgets similarly
}
