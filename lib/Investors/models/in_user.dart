class InvestorUser {
  final String firstname;
  final String lastname;
  final String email;
  final String username;
  final String password;
  final String token;

  InvestorUser({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'username': username,
      'password': password,
      'token': token,
    };
  }
}
