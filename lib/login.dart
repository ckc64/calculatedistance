import 'package:flutter/material.dart';
import 'package:project/admin.dart';
import 'package:project/roundedbutton.dart';
import 'package:project/signup.dart';
import 'package:project/signupadmin.dart';
import 'package:project/signupestablishment.dart';
class LoginAs extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginAsState createState() => _LoginAsState();
}

class _LoginAsState extends State<LoginAs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Login As'),
        actions: [
        FlatButton(
         child: Text('Admin',style: TextStyle(
            color: Colors.deepOrange,
          ),),
          onPressed: (){
            return Navigator.pushNamed(context, SignUpAdmin.id);
          },
        )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('images/scan.jpg'),
                ),
                RoundedButton(
                  title: 'Individual',
                  colour: Colors.deepOrange,
                  onPressed: () {
                    Navigator.pushNamed(context, SignUp.id);
                  },
                ),
                RoundedButton(
                  title: 'Establishment',
                  colour: Colors.deepOrange,
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpEstablishment.id);
                  },
                ),
                // RoundedButton(
                //   title: 'Admin',
                //   colour: Colors.deepOrange,
                //   onPressed: () {
                //     Navigator.pushNamed(context, Admin.id);
                //   },
                // ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}
