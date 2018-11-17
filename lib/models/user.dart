class User {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String displayName;
  final String avatar;
  final String password;
  final String email;
  final String token;
  final String role;

  User({this.id = "",
        this.firstName = "", 
        this.lastName = "", 
        this.username = "", 
        this.displayName = "", 
        this.avatar = "", 
        this.password = "", 
        this.email = "", 
        this.token = "",
        this.role = ""});

  static User fromJson(dynamic json, String token) {
    return User(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      username: json["username"],
      displayName: json["displayName"],
      avatar: json["userImage"].replaceAll("PNG", "png").replaceAll("\\", "/"),
      password: json["password"],
      email: json["email"],
      token: token,
      role: json["userRole"]
    );
  }
}