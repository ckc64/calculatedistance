import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/signup.dart';
import 'package:project/constant/sharedcode.dart';

class Forgot extends StatefulWidget {
  static const String id = 'forgotpassword';

  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final auth = FirebaseAuth.instance;
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email Your Email',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Email ',labelText: 'Email Address',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Email Address': null,
                  onChanged: (value){
                    setState(() => email = value);
                  }
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Send Email'),
                onPressed: () {
                  auth.sendPasswordResetEmail(email: email.toString().trim());
                  Navigator.pushNamed(
                    context,
                    SignUp.id,
                  );
                },
              ),
              FlatButton(
                child: Text('Sign In'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}


