import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
class ViewScanned extends StatefulWidget {
  static const String id = 'viewallscanned';
  final String cid;
  ViewScanned(this.cid);
  @override
  _ViewScannedState createState() => _ViewScannedState();
}

class _ViewScannedState extends State<ViewScanned> {
  bool isLoading = false;
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
  getUser() async{
    setState(() {
      isLoading = true;
    });

    final docRef = FirebaseFirestore.instance
        .collection('personalData')
        .doc(widget.cid);
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
        print(doc);
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
      ),
      body: isLoading ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
          color:Colors.blueGrey[800],
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  title: Text("Full Name: $firstname $lastname" ,style: TextStyle(
                    fontSize: 18.0,
                    decoration: TextDecoration.none,
                    //fontFamily: 'COURI',
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Age: $age" ,style: TextStyle(
                    fontSize: 18.0,
                    decoration: TextDecoration.none,
                    //fontFamily: 'COURI',
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Mobile No. : $mobileno" ,style: TextStyle(
                    fontSize: 18.0,
                    decoration: TextDecoration.none,
                    //fontFamily: 'COURI',
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Address : $barangay $city" ,style: TextStyle(
                    fontSize: 18.0,
                    decoration: TextDecoration.none,
                    //fontFamily: 'COURI',
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("EmailAddress: $email" ,style: TextStyle(
                    fontSize: 18.0,
                    decoration: TextDecoration.none,
                    //fontFamily: 'COURI',
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
