import 'package:protect_me_mobile/environment.dart';
import 'package:protect_me_mobile/models/alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlertService {
  final _url = Environment.BACKEND_URL + "/alerts";
  
  Future<Alert> create(Map<String, dynamic> alert, String token) async {
    final response = await http.post(_url + "/alerts", body: alert, 
      headers: {
        "Authorization": "Bearer $token"
      });
    
    if (response.statusCode != 201)
      return null;
    
    return Alert.fromJson(jsonDecode(response.body));
  }
}