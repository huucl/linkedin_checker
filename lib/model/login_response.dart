import 'dart:convert';

LoginResponse loginResponseFromMap(String str) => LoginResponse.fromMap(json.decode(str));

String loginResponseToMap(LoginResponse data) => json.encode(data.toMap());

class LoginResponse {
  final User? user;
  final String? accessToken;

  LoginResponse({
    this.user,
    this.accessToken,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
    user: json["user"] == null ? null : User.fromMap(json["user"]),
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toMap() => {
    "user": user?.toMap(),
    "accessToken": accessToken,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginResponse &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          accessToken == other.accessToken;

  @override
  int get hashCode => user.hashCode ^ accessToken.hashCode;
}

class User {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? status;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.status,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          role == other.role &&
          status == other.status;

  @override
  int get hashCode =>
      id.hashCode ^ email.hashCode ^ firstName.hashCode ^ lastName.hashCode ^ role.hashCode ^ status.hashCode;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    role: json["role"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "role": role,
    "status": status,
  };
}
