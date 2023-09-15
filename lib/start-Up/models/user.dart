class CompanyUser {
  final String username;
  final String email;
  final String password;
  final String name;
  final String dob;
  final int age;
  final String gender;
  final String phoneNo;
  final String officeNo;

  final String designation;
  final String state;
  final String city;
  final String officeAddress;
  final int officePincode;
  final String token;

  CompanyUser({
    required this.token,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.dob,
    required this.age,
    required this.gender,
    required this.phoneNo,
    required this.officeNo,
    required this.designation,
    required this.state,
    required this.city,
    required this.officeAddress,
    required this.officePincode,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'dob': dob,
      'age': age,
      'gender': gender,
      'phoneNo': phoneNo,
      'officeNo': officeNo,
      'designation': designation,
      'state': state,
      'city': city,
      'officeAddress': officeAddress,
      'officePincode': officePincode,
    };
  }
}
