import 'package:protect_me_mobile/environment.dart';
import 'package:protect_me_mobile/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String _url = Environment.BACKEND_URL + "/users";

  Future<User> login(String username, String password) async {
    print("Login");
    final response = await http.post(_url + "/login", body: {"username": username, "password": password});
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    return User();
  }
}