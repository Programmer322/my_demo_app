class User {
  final int id;
  final String username;
  final String phoneNumber;
  final String password;
  final DateTime signUpTime;

  User({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.password,
    required this.signUpTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'phone_number': phoneNumber,
      'password': password,
      'sign_up_time': signUpTime.toIso8601String(),
    };
  }
  User.clone(User user)
      : id = user.id,
        username = user.username,
        phoneNumber = user.phoneNumber,
        password = user.password,
        signUpTime = user.signUpTime;
  // Factory method to create User object from a map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      phoneNumber: map['phone_number'],
      password: map['password'],
      signUpTime: DateTime.parse(map['sign_up_time']),
    );
  }
}
