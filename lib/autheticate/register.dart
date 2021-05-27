import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/auth.dart';
import 'package:project/constant/loading.dart';
import 'package:project/constant/sharedcode.dart';
import 'package:project/home.dart';
import 'package:project/scanner.dart';
import 'package:project/signup.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:project/model/userlocation.dart';
import 'package:project/viewallcoordinates.dart';
import 'package:provider/provider.dart';
import 'package:shortid/shortid.dart';
import 'package:project/roundedbutton.dart';

class Register extends StatefulWidget {
  static const String id = 'register';
  const Register({Key key}): super(key: key);
  // final Function toggleView;
  // Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool vis = true;
  bool _passwordVisible = false;
  DateTime now = DateTime.now();
  String initValue="Select your Birth Date";
  bool isDateSelected= false;
  DateTime birthDate; // instance of DateTime
  String birthDateInString;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseFirestore.instance;
  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String gender1;
  List list = ['male','female','others'];
  String email='' ;
  String password='';
  String error='';
  bool loading = false;
  String firstname;
  String lastname;
  String gender;
  String dateofbirth;
  String mobilenum;
  String age;
  String valueChoose;
  String address,city,purok,barangay;
  List listItem=[
    'Male','Female','Others'
  ];
  DateTime currentValue1;
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
     var userLocation = Provider.of<UserLocation>(context);
    return loading ? Loading(): Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(

        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Registration'),
        actions: [
          // FlatButton.icon(
          //   icon: Icon(Icons.person,color: Colors.white,),
          //   label: Text('Sign In',style: TextStyle(
          //     color: Colors.white
          //   ),),
          //   onPressed: (){
          //     Navigator.pushNamed(context, SignUp.id);
          //   },
          // )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text('REQUIRED(*)',style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Your First Name',labelText: 'First Name*',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey[900],
                  )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your First Name' : null,
                  onChanged: (value){
                    setState(() => firstname = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Your Last Name',labelText: 'Last Name*',
                    labelStyle: TextStyle(
                    color: Colors.blueGrey[900],

                  )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Last Name' : null,
                  onChanged: (value){
                    setState(() => lastname = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Your Age',labelText: 'Age*',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],

                      )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Age' : null,
                  onChanged: (value){
                    setState(() => age = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(

                    hint:  Text('Gender*'),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    underline: SizedBox(

                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    value: valueChoose,
                    onChanged: (newValue){
                      setState(() {
                        valueChoose = newValue;
                        print(valueChoose);
                      });
                    },
                    items :listItem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                    ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Mobile Number',labelText: 'Mobile Number*',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Mobile Number' : null,
                  onChanged: (value){
                    setState(() => mobilenum = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'City/Municipality',labelText: 'City/Municipality*',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Address' : null,
                  onChanged: (value){
                    setState(() => city = value);
                  },
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'Barangay*',labelText: 'Barangay*',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Purok/Street' : null,
                  onChanged: (value){
                    setState(() => barangay = value);
                  },
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'Current Address*',labelText: 'Street, Purok*',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Address' : null,
                  onChanged: (value){
                    setState(() => purok = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontSize: 20,
                    ),
                    decoration: textInputDecoration.copyWith(hintText: 'Enter Email ',labelText: 'Email Address*',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[900],
                        )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Email Address': null,
                    onChanged: (value){
                      setState(() => email = value);
                    }
                ),
                SizedBox(height: 20.0,
                ),
                TextFormField(
                  obscureText: vis,
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Password',labelText: 'Password*',
                      // icon: const Padding(padding: const EdgeInsets.only(top: 15.0),
                      //     child: const Icon(Icons.remove_red_eye),),
                      // prefixIcon: IconButton(
                      //   icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off,),
                      //   onPressed: (){
                      //      vis=false;
                      //   },
                      // ),
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.length < 6  ? 'enter password 6+ chars long' : null,
                  onChanged: (value){
                    setState(() => password = value);
                  },
                ),
                SizedBox(height :20.0),
                RoundedButton(
                  title: 'Submit',
                  colour: Colors.deepOrange,
                  onPressed: ()async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true
                      );
                      //dynamic result = await auth.registerWithEmailandPassword(email, password);
                      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                      User user = result.user;
                      String id=shortid.generate();
                      _firestore.collection('personalData').doc(user.uid).set({
                        'id':user.uid,
                        'firstname':firstname.toUpperCase(),
                        'lastname':lastname.toUpperCase(),
                        'age':age,
                        'gender':valueChoose.toUpperCase(),
                        'mobileno':mobilenum,
                        'city':city.toUpperCase(),
                        'purok':purok.toUpperCase(),
                        'barangay':barangay.toUpperCase(),
                        'email':email,
                        'password':password,
                        'currentPosition':[userLocation.latitude,userLocation.longitude]
                      });
                      await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>Home()));
                    }
                  // await Navigator.pushNamed(context, Home.id);
                  },
                ),


                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: RaisedButton(
                //     color: Colors.deepOrange,
                //     child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 18),
                //     ),
                //     onPressed: ()async{
                //       if(_formKey.currentState.validate()){
                //         setState(() => loading = true
                //         );
                //         //dynamic result = await auth.registerWithEmailandPassword(email, password);
                //         UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                //          User user = result.user;
                //          String id=shortid.generate();
                //         _firestore.collection('personalData').doc(user.uid).set({
                //           'id':id.toUpperCase(),
                //           'firstname':firstname.toUpperCase(),
                //           'lastname':lastname.toUpperCase(),
                //           'age':age,
                //           'gender':valueChoose.toUpperCase(),
                //            'mobileno':mobilenum,
                //           'address':address.toUpperCase(),
                //           'email':email,
                //           'password':password,
                //           'currentPosition':[userLocation.latitude,userLocation.longitude]
                //         });
                //         await Navigator.of(context).push(
                //             MaterialPageRoute(builder: (context)=>Home()));
                //       }
                //     },
                //   ),
                // ),
                SizedBox(height: 12.0,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
