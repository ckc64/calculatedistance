import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/auth.dart';
import 'package:project/constant/loading.dart';
import 'package:project/constant/sharedcode.dart';
import 'package:project/home.dart';
import 'roundedbutton.dart';

class UpdateData extends StatefulWidget {
  static const String id = 'updateData';
  final Function toggleView;

  UpdateData({this.toggleView});
  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  String valueChoose;
  List listItem=[
    'Male','Female','Others'
  ];
  String currentUserID;
  User loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseFirestore.instance;
  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email='' ;
  String password='';
  String error='';
  bool loading = false;
  FirebaseAuth fAuth = FirebaseAuth.instance;
  TextEditingController firstname =  TextEditingController();
  TextEditingController lastname =  TextEditingController();
  TextEditingController gender =  TextEditingController();
  TextEditingController dateofbirth =  TextEditingController();
  TextEditingController mobileno =  TextEditingController();
  TextEditingController address =  TextEditingController();
  TextEditingController age =  TextEditingController();
  TextEditingController city =  TextEditingController();
  TextEditingController barangay =  TextEditingController();
  TextEditingController purok =  TextEditingController();

  getUser() async{
    setState(() {
      isLoading = true;
    });

    final docRef = FirebaseFirestore.instance
        .collection('personalData')
        .doc(loggedInUser.uid);
    docRef.get().then((doc){
      if (doc.exists) {
         currentUserID = doc.data()['id'];
        firstname.text = doc.data()['firstname'];
        lastname.text = doc.data()['lastname'];
         age.text = doc.data()['age'];
        gender.text = doc.data()['gender'];
        dateofbirth.text = doc.data()['dateofbirth'];
        mobileno.text = doc.data()['mobileno'];
        city.text = doc.data()['city'];
         barangay.text = doc.data()['barangay'];
         purok.text = doc.data()['purok'];

         print(doc);
        print(currentUserID);
         print(doc.data()['firstname']);
        setState(() {
          isLoading = false;
        });
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });

  }
  void getCurrentUser() async {
    isLoading = true;
    try{
      final user = await fAuth.currentUser;
      if (user != null) {
        loggedInUser = user;
        setState(() {
          currentUserID = loggedInUser.uid;
          isLoading = false;
          getUser();
        });
      }
    }catch(e){
      print(e);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
        title: Text('Update Information'),
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
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  controller: firstname,
                  //decoration: InputDecoration(labelText: 'First Name'),
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Your First Name',labelText: 'First Name',labelStyle: TextStyle(
                    color: Colors.blueGrey[900],
                  )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your First Name' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  controller: lastname,
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Your Last Name',labelText: 'Last Name',labelStyle: TextStyle(
                    color: Colors.blueGrey[900],
                  )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Last Name' : null,

                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  controller: age,
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Your Age',labelText: 'Age',labelStyle: TextStyle(
                    color: Colors.blueGrey[900],
                  )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Last Name' : null,

                ),

                // DropdownButton(
                //   hint:  Text('Gender'),
                //   dropdownColor: Colors.white,
                //   icon: Icon(Icons.arrow_drop_down),
                //   iconSize: 36,
                //   isExpanded: true,
                //   underline: SizedBox(
                //
                //   ),
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 20,
                //   ),
                //   value: valueChoose,
                //   onChanged: (newValue){
                //     setState(() {
                //       valueChoose = newValue;
                //       print(valueChoose);
                //     });
                //   },
                //   items :listItem.map((valueItem) {
                //     return DropdownMenuItem(
                //       value: valueItem,
                //       child: Text(valueItem),
                //     );
                //   }).toList(),
                // ),

                // TextFormField(
                //   style: TextStyle(
                //     color: Colors.blueGrey[900],
                //     fontSize: 20,
                //   ),
                //   controller: dateofbirth,
                //   decoration: textInputDecoration.copyWith(hintText: 'Enter Your Date of Birth',labelText: 'Date of Birth',labelStyle: TextStyle(
                //     color: Colors.blueGrey[900],
                //   )),
                //   validator: (value)=> value.isEmpty ? 'Please Input Your Date of Birth' : null,
                // ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  controller: mobileno,
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Your Mobile Number',labelText: 'Mobile Number',labelStyle: TextStyle(
                    color: Colors.blueGrey[900],
                  )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Mobile Number' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  controller: city,
                  //keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(hintText: 'City/Municipality',labelText: 'City/Municipality',labelStyle: TextStyle(
                    color: Colors.blueGrey[900],
                  )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your City/Municipality' : null,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  controller: barangay,
                  //keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(hintText: 'Barangay',labelText: 'Barangay',labelStyle: TextStyle(
                    color: Colors.blueGrey[900],
                  )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Barangay' : null,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20,
                  ),
                  controller: purok,
                  //keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(hintText: 'Purok',labelText: 'Purok,Street',labelStyle: TextStyle(
                    color: Colors.blueGrey[900],
                  )),
                  validator: (value)=> value.isEmpty ? 'Please Input Your Barangay' : null,
                ),

                SizedBox(height :20.0),
                RoundedButton(
                  title: 'Update',
                  colour: Colors.deepOrange,
                  onPressed: () async{

                    print(currentUserID);
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true
                      );
                      //dynamic result = await auth.registerWithEmailandPassword(email, password);
                      // UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                      //User user = result.user;
                      _firestore.collection('personalData').doc(currentUserID).update({
                        // 'id':user.uid,
                        'firstname':firstname.text.toUpperCase(),
                        'lastname':lastname.text.toUpperCase(),
                        'age':age.text,
                        //'gender':valueChoose.toUpperCase(),
                        'mobileno':mobileno.text,
                        'city':city.text.toUpperCase(),
                        'barangay':barangay.text.toUpperCase(),
                        'purok':purok.text.toUpperCase(),

                      });

                    }
                    setState(()
                    => loading =false
                    );
                    Navigator.pushNamed(context, Home.id);
                    Navigator.pushNamed(context, Home.id);
                  },
                ),


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
