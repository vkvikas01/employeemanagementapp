import 'dart:convert';

class Profile {
   int id;
 final String first_name;
 final String last_name;
 final String designation;
 final String department;
 final String email;
 final int contact_number;
 final String dob;
 final String date_of_joining;

  Profile(
      { this.id = 0,
     required this.first_name,
     required this.last_name,
     required this.designation,
     required this.department,
     required this.email,
     required this.contact_number,
     required this.dob,
     required this.date_of_joining});

  factory Profile.fromJson(map) {
    return Profile(
        id: map["id"],
        first_name: map["first_name"],
        last_name: map["last_name"],
        designation: map["designation"],
        department: map["department"],
        email: map["email"],
        contact_number: map["contact_number"],
        dob: map['dob'],
        date_of_joining: map['date_of_joining']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": first_name,
      "last_name": last_name,
      "designation": designation,
      "department": department,
      "email": email,
      "contact_number": contact_number,
      "dob": dob,
      "date_of_joining": date_of_joining
    };
  }

  @override
  String toString() {
    return 'Profile{id: $id,first_name: $first_name,last_name: $last_name,designation: $designation,department: $department,email: $email,contact_number: $contact_number,dob: $dob,date_of_joining: $date_of_joining}';
  }
}

List<Profile> profileFromJson(jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
