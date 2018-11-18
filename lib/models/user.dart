import 'package:protect_me_mobile/environment.dart';

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
    String urlPhoto = json["userImage"];
    if (!json["userImage"].startsWith("http")) {
      urlPhoto = Environment.BACKEND_URL + "/" +  urlPhoto.replaceAll("PNG", "png").replaceAll("\\", "/");
    }
    return User(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      username: json["username"],
      displayName: json["displayName"],
      avatar: urlPhoto,
      password: json["password"],
      email: json["email"],
      token: token,
      role: json["userRole"]
    );
  }

  static User fromDocument(dynamic json) {
    String urlPhoto = json["photoURL"].replaceAll("PNG", "png").replaceFirst(RegExp(r'\\'), "/");
    if (!json["photoURL"].startsWith("http")) {
      urlPhoto = Environment.BACKEND_URL + "/" +  urlPhoto;
    }

    print(urlPhoto);

    return User(
      username: json["username"],
      displayName: json["displayName"],
      avatar: urlPhoto,
    );
  }

  Map<String, String> toJson() {
    return {
      "userImage": avatar,
      "username": username,
      "photoURL": avatar,
    };
  }
}