
import 'package:flutter/material.dart';
import 'package:protect_me_mobile/widgets/text_field.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  
  String firstName;
  String lastName;
  String username;
  String password;
  String password1;
  
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
                      ProtectMeTextField(name:"First name", onValid: (value) => this.firstName = value),
                      ProtectMeTextField(name: "Last name", onValid: (value) => this.lastName = value),
                      ProtectMeTextField(name: "Username", onValid: (value) => this.username = value),
                      ProtectMeTextField(name:"Password", onValid: (value) => this.password = value),
                      ProtectMeTextField(name: "Repeat password", onValid: (value) => this.password1 = value),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: RaisedButton(
                          padding: EdgeInsets.all(20),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Scaffold.of(context)
                                  .showSnackBar(SnackBar(content: Text('Processing Data')));
                            }
                          },
                          color: Colors.redAccent,
                          child: Text('Sign up', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Roboto'),),
                        ),
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