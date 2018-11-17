import 'dart:io';
import 'package:dio/dio.dart';

import 'package:protect_me_mobile/environment.dart';
import 'package:protect_me_mobile/models/alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:protect_me_mobile/models/user.dart';

class AlertService {
  final _url = Environment.BACKEND_URL + "/alerts";
  
  Future<Alert> create(Map<String, String> alert, User user) async {
    final response = await http.post(_url, body: alert, 
      headers: {
        "Authorization": "Bearer ${user.token}"
      }
    );
    
    if (response.statusCode != 201)
      return null;
    
    return Alert.fromJson(jsonDecode(response.body)["alert"], user);
  }

  Future<Alert> createWithAudio(Map<String, dynamic> alert, User user) async {
    final audioPath = alert["audioPath"];
    FormData formData = new FormData.from({
      "severiry": alert["severity"],
      "createdBy": alert["createdBy"],
      "latitude": alert["latitude"],
      "longitude": alert["longitude"],
      "audio": UploadFileInfo(File(alert["audioPath"]), "$audioPath.mp4"),
    });

    final dio = Dio();
    dio.options.headers = {
      "Authorization": "Bearer ${user.token}"
    };

    final response = await dio.post(_url + "/audio", data: formData);
    
    if (response.statusCode != 201)
      return null;
    
    return Alert.fromJson(jsonDecode(response.data), user);
  }
}