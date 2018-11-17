
import 'package:flutter/material.dart';
import 'package:protect_me_mobile/pages/home_page/home_page.dart';
import 'package:protect_me_mobile/pages/login_page/login_page.dart';
import 'package:protect_me_mobile/pages/signup_page/signup_page.dart';

class Router {
  static Map<String, dynamic> params = new Map();
  
  static var routes = <String, WidgetBuilder> {
    '/login_page': (_) => new LoginPage(),
    '/signup_page': (_) => new SignupPage(),
    '/home_page': (_) => new HomePage(user: params["user"],),
  };
}