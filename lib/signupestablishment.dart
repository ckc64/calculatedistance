import 'package:flutter/material.dart';
import 'package:project/constant/loading.dart';
import 'package:project/constant/sharedcode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/model/user.dart';
import 'package:project/scanner.dart';
import 'package:project/welcome.dart';
import 'package:project/roundedbutton.dart';

class SignUpEstablishment extends StatefulWidget {
  static const String id = 'signupestablishment';
  @override
  _SignUpEstablishmentState createState() => _SignUpEstablishmentState();
}

class _SignUpEstablishmentState extends State<SignUpEstablishment> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _obscureText = true;
  String username = '';
  String password = '';
  String error='';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          // FlatButton(
          //  child: Text('Back',style: TextStyle(
          //     color: Colors.white,
          //   ),),
          //   onPressed: (){
          //     return Navigator.pushNamed(context, Welcome.id);
          //   },
          // )
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Login as Establishment'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    decoration: textInputDecoration.copyWith(hintText: 'Enter Username',labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[900],

                        )),
                    validator: (value)=> value.isEmpty ? 'Enter Username' : null,
                    onChanged: (value){
                      setState(() => username = value);
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
                  validator: (value)=> value.length < 6  ? 'enter password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (value){
                    setState(() => password = value);
                  },
                ),
                // FlatButton(
                //   onPressed: () {
                //     Navigator.pushNamed(
                //       context,
                //       ForgotPassword.id,
                //     );
                //   },
                //   child: Text(
                //     'Forgot Password?',
                //     textAlign: TextAlign.right,
                //     style: TextStyle(color: Colors.grey, fontSize: 12),
                //   ),
                // ),
                SizedBox(height: 20.0,
                ),
                RoundedButton(
                  title: 'Login',
                  colour: Colors.deepOrange,
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      try{
                        // UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        // User user = result.user;
                        // await Navigator.pushNamed(context, Scanner.id);
                        return Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>Scanner(username,password)));
                        // if(user==null){
                        //   error ='could not sign in with those credentials';
                        //   loading = true;
                        //   print(error);
                        // }
                        // return user != null ? Users(uid: user.uid) : null;
                      }catch(e){
                      }
                    }
                    // Navigator.pushNamed(context, Register.id);
                  },
                ),
                // RaisedButton(
                //   color: Colors.deepOrange,
                //   child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 18),),
                //   onPressed: ()async{
                //     if(_formKey.currentState.validate()){
                //       _formKey.currentState.save();
                //       try{
                //         // UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
                //         // User user = result.user;
                //        // await Navigator.pushNamed(context, Scanner.id);
                //         return Navigator.of(context).push(
                //             MaterialPageRoute(builder: (context)=>Scanner(username,password)));
                //         // if(user==null){
                //         //   error ='could not sign in with those credentials';
                //         //   loading = true;
                //         //   print(error);
                //         // }
                //         // return user != null ? Users(uid: user.uid) : null;
                //       }catch(e){
                //       }
                //     }
                //   },
                // ),
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
