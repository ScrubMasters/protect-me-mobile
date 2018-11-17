import 'package:protect_me_mobile/environment.dart';
import 'package:protect_me_mobile/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  String _url = Environment.BACKEND_URL + "/users";

  Future<User> login(String username, String password) async {
    final response = await http.post(_url + "/login", body: {"username": username, "password": password});
    return User.fromJson(jsonDecode(response.body)["user"], jsonDecode(response.body)["token"]);
  }

  Future<User> signUp(Map<String, String> body) async {
    final signUpResponse = await http.post(_url + "/signup", body: body);
    if(signUpResponse.statusCode == 201) {
      return await login(body["username"], body["password"]);
    }
    return null;
  }
}