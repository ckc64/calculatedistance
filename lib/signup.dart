import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/auth.dart';
import 'package:project/autheticate/establishment.dart';
import 'package:project/autheticate/register.dart';
import 'package:project/constant/loading.dart';
import 'package:project/constant/sharedcode.dart';
import 'package:project/home.dart';
import 'package:project/scanner.dart';
import 'forgotpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model/user.dart';
import 'package:project/roundedbutton.dart';
final userRef =FirebaseFirestore.instance.collection('personalData');
class SignUp extends StatefulWidget {
  static const String id = 'signup';
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _obscureText = true;
  final AuthService auth = AuthService();
  String email = '';
  String password = '';
  String error='';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Login as Individual'),
        // actions: [
        //   FlatButton.icon(
        //     icon: Icon(Icons.person,
        //     color: Colors.white,),
        //     label: Text('Register',style: TextStyle(
        //       color: Colors.white,
        //     ),),
        //     onPressed: (){
        //       Navigator.pushNamed(context, Register.id);
        //     },
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('images/scan.jpg'),
          //         fit: BoxFit.cover
          //     )
          // ),
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(

                  style: TextStyle(
                    fontSize: 20,
                  ),
                    decoration: textInputDecoration.copyWith(hintText: 'Enter Email Address',labelText: 'Email Address',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[900],

                        )),
                    validator: (value)=> value.isEmpty ? 'enter email' : null,
                  onChanged: (value){
                    setState(() => email = value);
                  }

                ),
                SizedBox(height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Password',labelText: 'Password',

                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.length < 6  ? 'short password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (value){
                    setState(() => password = value);
                  },
                ),
                // FlatButton(
                //   onPressed: () {
                //     Navigator.pushNamed(
                //       context,
                //       Forgot.id,
                //     );
                //   },
                //   child: Text(
                //     'Forgot Password?',
                //     textAlign: TextAlign.right,
                //     style: TextStyle(color: Colors.grey, fontSize: 12),
                //   ),
                // ),
                RoundedButton(
                  title: 'Sign In',
                  colour: Colors.deepOrange,
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      try{
                        UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        User user = result.user;
                        if(user==null){
                          error ='could not sign in with those credentials';
                          loading = true;
                        }
                        await Navigator.pushNamed(context, Home.id);
                        return user != null ? Users(uid: user.uid) : null;

                      }catch(e){
                      }
                      return Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>Home()));
                    }
                    //Navigator.pushNamed(context, Register.id);
                  },
                ),
                // RaisedButton(
                //   color: Colors.deepOrange,
                //   child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 18),),
                //   onPressed: ()async{
                //
                //     //dynamic result = await auth.signUpWithEmailandPassword(email, password);
                //     if(_formKey.currentState.validate()){
                //       _formKey.currentState.save();
                //       try{
                //         UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
                //         User user = result.user;
                //         if(user==null){
                //           error ='could not sign in with those credentials';
                //           loading = true;
                //           print(error);
                //         }
                //         await Navigator.pushNamed(context, Home.id);
                //         return user != null ? Users(uid: user.uid) : null;
                //
                //       }catch(e){
                //       }
                //       return Navigator.of(context).push(
                //           MaterialPageRoute(builder: (context)=>Home()));
                //     }
                //   },
                // ),
                FlatButton(
                  onPressed: () {

                    Navigator.pushNamed(
                      context,
                      Register.id,
                    );
                  },
                  child: Text(
                    'Don\'t have an account? SIGN UP',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 18),
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 18.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

