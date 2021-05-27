import 'package:flutter/material.dart';
import 'package:project/constant/sharedcode.dart';
import 'package:project/scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/roundedbutton.dart';

class Establishment extends StatefulWidget {
  static const String id = 'establishment';
  @override
  _EstablishmentState createState() => _EstablishmentState();
}

class _EstablishmentState extends State<Establishment> {
  final _formKey = GlobalKey<FormState>();
  String error='';
  bool loading = false;
  String email;
  String password;
  String establishment_name;
  String establishment_type;
  String barangay;
  String address;
  String choosetype;
  String contactno;
  String username;
  List listtype=[
    'Agriculture','Bank','Barangay Hall','Check Point','Church','City Hall','Convenience Store','Department Store','Grovernment Office','Hospital',
    'Hotel','Laboratory','Mall','Market','Restaurant','School','Store'
  ];
  String type;
  List listbarangay=[
    'Apokon','Bincungan','Busaon','Cuambogan','La Filipina','Liboganon','Madaum','Magdum','Magugpo Poblacion','Magugpo East',
    'Magugpo North','Magugpo South','Magugpo West','Mankilam','New Balamban','Nueva Fuerza','Pagsabangan','Pandapan','San Agustin',
    'San Isidro','San Miguel (Camp 4)','Visayan Village',
  ];
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Establishment Registration'),
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
                Center(
                  child: Text('(*) is REQUIRED',style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(labelText: 'Establishment Name*',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.isEmpty ? 'Please Input Establishment Name' : null,
                  onChanged: (value){
                    setState(() => establishment_name = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(
                  hint:  Text('Establishment Type*'),
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
                  value: choosetype,
                  onChanged: (newValue){
                    setState(() {
                      choosetype = newValue;
                      print(choosetype);
                    });
                  },
                  items :listtype.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(
                  hint:  Text('Barangay*'),
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
                  value: barangay,
                  onChanged: (newValue){
                    setState(() {
                      barangay = newValue;
                      print(barangay);
                    });
                  },
                  items :listbarangay.map((valueItem) {
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
                  decoration: textInputDecoration.copyWith(labelText: 'Complete Address *',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.isEmpty ? 'Please Input Address is Required' : null,
                  onChanged: (value){
                    setState(() => address = value);
                  },
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(labelText: 'User Name*',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  validator: (value)=> value.isEmpty ? 'Please Input User Name' : null,
                  onChanged: (value){
                    setState(() => username = value);
                  },
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Password',labelText: 'Password*',
                      // prefixIcon: IconButton(
                      //   icon: Icon(Icons.remove_red_eye),
                      //   onPressed: null,
                      // ),
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[900],
                      )),
                  obscureText: true,
                  validator: (value)=> value.length < 6  ? 'enter password 6+ chars long' : null,
                  onChanged: (value){
                    setState(() => password = value);
                  },
                ),

                SizedBox(height :20.0),
                RoundedButton(
                  title: 'Register',
                  colour: Colors.deepOrange,
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true
                      );
                      _firestore.collection('establishmentData').doc(username).set({
                        'establishmentname':establishment_name,
                        'establishmenttype':choosetype,
                        'barangay':barangay,
                        'establishmentaddress':address,
                        'password':password,
                      });
                      //await  Navigator.pushNamed(context, Scanner.id);
                      await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>Scanner(username,password)));
                    }
                   // Navigator.pushNamed(context, Establishment.id);
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>Scanner(username,password)));
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
                //         _firestore.collection('establishmentData').doc(username).set({
                //           'establishmentname':establishment_name,
                //           'establishmenttype':choosetype,
                //           'barangay':barangay,
                //           'establishmentaddress':address,
                //           'password':password,
                //         });
                //         //await  Navigator.pushNamed(context, Scanner.id);
                //        await Navigator.of(context).push(
                //             MaterialPageRoute(builder: (context)=>Scanner(username,password)));
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
