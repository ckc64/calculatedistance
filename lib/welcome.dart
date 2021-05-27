import 'package:flutter/material.dart';
import 'package:project/autheticate/establishment.dart';
import 'package:project/autheticate/register.dart';
import 'package:project/login.dart';
import 'package:project/roundedbutton.dart';
import 'package:project/signup.dart';
import 'package:project/signupestablishment.dart';

class Welcome extends StatefulWidget {
  static const String id = 'welcome';
  @override
  _WelcomeState createState() => _WelcomeState();
}
class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Welcome'),
        actions: [
          FlatButton(
            child: Text('Login as',style: TextStyle(
              color: Colors.deepOrange,
            ),),
            onPressed: (){
              Navigator.pushNamed(context, LoginAs.id);
            },
          )
        ],
      ),
     // drawer: Drawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50.0,
              ),
             Text('Welcome to',style: TextStyle(
               fontSize: 40,
               fontWeight: FontWeight.bold,
             ),),
              Text('Q+detoR',style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20.0,
              ),
              SizedBox(height: 20.0,
              ),
              Text('I\'d like to Register as an ',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),),
              SizedBox(height: 20.0,
              ),
              RoundedButton(
                title: 'Individual',
                colour: Colors.deepOrange,
                onPressed: () {
                  Navigator.pushNamed(context, Register.id);
                },
              ),
              RoundedButton(
                title: 'Establishment',
                colour: Colors.deepOrange,
                onPressed: () {
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Column(
                        children: [
                         // Text('IMPORTANT!!!Who should register for Establishment?'),
                          SizedBox(height: 20.0,
                          ),
                          Center(
                            child: Text('This is for registration of ESTABLISHMENTS only. If you are an INDIVIDUAL, please DO NOT REGISTER.',
                              style: TextStyle(

                            ),),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            FlatButton(
                              child: Text('close',style: TextStyle(
                                color: Colors.deepOrange,
                              ),),
                              onPressed: () {
                                //Navigator.of(context).pop();
                                Navigator.pushNamed(context, Welcome.id);
                              },
                            ),
                            FlatButton(
                              child: Text('proceed',style: TextStyle(
                              color: Colors.deepOrange,
                    ),),
                              onPressed: () {
                                //Navigator.of(context).pop();
                                Navigator.pushNamed(context, Establishment.id);
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  });
                  //Navigator.pushNamed(context, Establishment.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
