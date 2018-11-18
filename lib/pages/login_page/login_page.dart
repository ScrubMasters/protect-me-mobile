import 'package:flutter/material.dart';
import 'package:protect_me_mobile/routing.dart';
import 'package:protect_me_mobile/services/auth_service.dart';
import 'package:protect_me_mobile/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: new Image.asset(
                    'assets/logo.png',
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ProtectMeTextField(name:"Username", onValid: (value) => this._username = value,padding: 20,),
                      ProtectMeTextField(name: "Password", onValid: (value) => this._password = value, padding: 20,),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: RaisedButton(
                          padding: EdgeInsets.all(20),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              
                              AuthService().login(_username, _password).then(
                                (user) {
                                  if (user == null) {
                                    Scaffold.of(context)
                                      .showSnackBar(SnackBar(content: Text('Invalid account')));
                                  } else {
                                    Router.params["user"] = user;
                                    Navigator.of(context).pushNamed("/home_page"); 
                                  }
                                }
                              );
                            }
                          },
                          color: Colors.redAccent,
                          child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Roboto'),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed("/signup_page"),
                          child: Text("Get an account"),
                        )
                      ),
                    ],
                  ),
                )
              ]
            )
          );
        },
      )
    );
  }
}