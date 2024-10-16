class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? token;

  User(this.id, this.firstName, this.lastName, this.email, this.token);

  factory User.fromJson(Map<String, dynamic> response) {
    final userData = response['user'];
    return User(userData['_id'], userData['forename'], userData['surname'],
        userData['email'], userData['token']);
  }
}
