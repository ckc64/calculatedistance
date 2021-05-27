import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:project/auth.dart';
import 'package:project/autheticate/register.dart';
import 'package:project/signup.dart';
import 'package:project/updateData.dart';
import 'package:project/welcome.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/database.dart';
import 'package:project/location.dart';
import 'package:project/model/userlocation.dart';
import 'package:screenshot/screenshot.dart';
import 'roundedbutton.dart';
import 'dart:math' show cos, sqrt, asin;
bool isLoading = false;
final _firestore = FirebaseFirestore.instance;
double lat;
double long;
class Home extends StatefulWidget {
  static const String id = 'home';
  String currentUserID;
  // final String cid;
  // Home(this.cid);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  Uint8List _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;
  FirebaseAuth fAuth = FirebaseAuth.instance;
  User loggedInUser;
  String currentUserID;
  String lastname;
  String address;
  String mobileno;
  String dateofbirth;
  String firstname;
  String gender;
  String qrdataFeed;
  String email;
  String password;
  String age;
  String currentPosition;
  String cid;
  String city;
  String barangay;
  void _signOut() {
    FirebaseAuth.instance.signOut();
    User user = FirebaseAuth.instance.currentUser;
    print('$user');
   return Navigator.pop(context);
  }

  getUser() async{
    setState(() {
      isLoading = true;
    });

    final docRef = FirebaseFirestore.instance
        .collection('personalData')
        .doc(loggedInUser.uid);
    print(currentUserID);
    docRef.get().then((doc){
      if (doc.exists) {
        firstname = doc.data()['firstname'];
        lastname = doc.data()['lastname'];
        age = doc.data()['age'];
        city = doc.data()['city'];
        barangay = doc.data()['barangay'];
        mobileno = doc.data()['mobileno'];
        email = doc.data()['email'];
        password = doc.data()['password'];
        currentPosition = doc.data()['currentPosition'].toString();
        print(doc);
        print(doc.data()['firstname']);
        print('Current Position:${doc.data()['currentPosition']}');
        final coord = currentPosition.split(",");
        final coordLat = coord[0].replaceAll('[', "");
        final coordLong = coord[1].replaceAll("]", "");
        lat = double.parse(coordLat);
        long = double.parse(coordLong);
        // print('$firstname lat:$lat');
        // print('long:$long');

        // print(doc.data()['id']);
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
      print('users$user');
      if (user != null) {
        loggedInUser = user;
        print('users$user');
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
    var userLocation = Provider.of<UserLocation>(context);
    final AuthService auth = AuthService();
    return Scaffold(
      //backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
        // actions: [
        //   FlatButton(
        //       child:Text('Logout',style: TextStyle(color: Colors.white),),
        //       onPressed: () async{
        //         //FirebaseAuth.instance.signOut();
        //         setState(() async{
        //           await fAuth.signOut();
        //           return Navigator.pop(context);
        //         });
        //
        //         },
        //   )
        // ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey[900]),
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                          child: QrImage(data: currentUserID,),
                        )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(child: Text('$firstname $lastname',style: TextStyle(fontSize: 18 , color: Colors.white),)),
                    Center(child: Text('$email',style: TextStyle(fontSize: 16 , color: Colors.white),)),
                    //Center(child: Text('${userLocation.latitude}${userLocation.longitude}',style: TextStyle(fontSize: 16 , color: Colors.white),))
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: (){
                return Navigator.pushNamed(context, UpdateData.id);
              },
            ),
            //SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: ()async{
                setState(() async{
                  await fAuth.signOut();
                  return Navigator.pushNamed(context, Welcome.id);
                });
              },
            ),
          ],
        ),
      ),
      body: isLoading ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
      ) : SingleChildScrollView(
        child: Container(
          //padding: EdgeInsets.all(10),
          //margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
          //color:Colors.blueGrey[800],
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text('This is your unique and permanent QR code',style: TextStyle(fontSize: 18.0),),
              // Text('($currentUserID)',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.fromLTRB(50,60,50,20),
                  child: QrImage(
                    backgroundColor: Colors.white,
                    //plce where the QR Image will be shown
                    data: currentUserID
                  ),
              ),
              // Text('Your Current Coordinates',style: TextStyle(fontSize: 18.0),),
              Text('Firstname :$firstname $lastname',style: TextStyle(fontSize: 18.0),),
              // Text('Longitude${userLocation.longitude}',style: TextStyle(fontSize: 18.0),),
              // SizedBox(
              //   height: 20.0,
              // ),
              // Card(
              //   child: ListTile(
              //     title: Text("Full Name: $firstname $lastname" ,style: TextStyle(
              //       fontSize: 18.0,
              //       decoration: TextDecoration.none,
              //       //fontFamily: 'COURI',
              //       fontWeight: FontWeight.w700,
              //     ),),
              //   ),
              // ),
              // Card(
              //   child: ListTile(
              //     title: Text("Age: $age" ,style: TextStyle(
              //       fontSize: 18.0,
              //       decoration: TextDecoration.none,
              //       //fontFamily: 'COURI',
              //       fontWeight: FontWeight.w700,
              //     ),),
              //   ),
              //
              // ),
              // Card(
              //   child: ListTile(
              //     title: Text("Address: $city $barangay" ,style: TextStyle(
              //       fontSize: 18.0,
              //       decoration: TextDecoration.none,
              //       //fontFamily: 'COURI',
              //       fontWeight: FontWeight.w700,
              //     ),),
              //   ),
              //
              // ),
              // Card(
              //   child: ListTile(
              //     title: Text("Mobile No,: $mobileno" ,style: TextStyle(
              //       fontSize: 18.0,
              //       decoration: TextDecoration.none,
              //       //fontFamily: 'COURI',
              //       fontWeight: FontWeight.w700,
              //     ),),
              //   ),
              //
              // ),
              // RoundedButton(
              //   title: 'Edit Profile',
              //   colour: Colors.deepOrange,
              //   onPressed: ()async {
              //     return Navigator.pushNamed(context, UpdateData.id);
              //   },
              // ),
            ],
          ),
        ),
      ),

    );

  }
}
