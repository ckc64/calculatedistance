import 'package:flutter/material.dart';
import 'package:project/admin.dart';
import 'package:project/constant/sharedcode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/scanner.dart';
import 'package:project/roundedbutton.dart';

class SignUpAdmin extends StatefulWidget {
  static const String id = 'admin';
  @override
  _SignUpAdminState createState() => _SignUpAdminState();
}
class _SignUpAdminState extends State<SignUpAdmin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  String admin = '';
  String password = '';
  String error='';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Login as Admin'),
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
                    decoration: textInputDecoration.copyWith(hintText: 'admin',labelText: 'admin',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[900],

                        )),
                    validator: (value)=> value.isEmpty ? 'admin' : null,
                    onChanged: (value){
                      setState(() => admin = value);
                    }

                ),
                SizedBox(height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'password',labelText: 'password',

                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.length < 6  ? 'enter password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (value){
                    setState(() => password = value);
                  },
                ),
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
                            MaterialPageRoute(builder: (context)=>Admin(admin,password)));
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
