class User {
  String? username;
  String? password;
  String? email;

  User({
    this.username,
    this.password,
    this.email,
  });
  
  // changing to json
  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        email: json["email"],
      );

      Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
      };
}
