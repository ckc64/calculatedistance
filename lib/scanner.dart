import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:project/signupestablishment.dart';
import 'package:project/test.dart';
import 'package:project/viewallscanned.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/auth.dart';
import 'package:intl/intl.dart';
import 'package:project/roundedbutton.dart';
import 'welcome.dart';
class Scanner extends StatefulWidget {
  static const String id = 'scanner';
    // something like 2013-04-20
  final String username;
  final String password;
  Scanner(this.username,this.password);
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  getScan()async{
    String codeScanner = await BarcodeScanner.scan(); //barcode scanner
    setState(() {
      qrCodeResult = codeScanner;
      if (qrCodeResult.isEmpty) {        //a little validation for the textfield
        setState(() {
          qrData = "";
        });
      } else {
        getUser(qrCodeResult);
        setState(() {
          qrData = qrCodeResult;
        });
      }
    });
  }
  final firestore = FirebaseFirestore.instance;
  String qrData ="";
  String uid;
  bool isLoading = false;
  FirebaseAuth fAuth = FirebaseAuth.instance;
  String qrCodeResult="";
  String currentUserID;
  String lastname;
  String address;
  String establishmentaddress;
  String mobileno;
  String dateofbirth;
  String firstname;
  String gender;
  String error;
  String email;
  String password;
  User loggedInEstablishment;
  String establishment_name;
  String establishment_type;
  String currentUserName;
  String barangay;
  String city;
  String purok;
  int user;
  String name,age,id;
  DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
  final AuthService auth = AuthService();
  getUser(String qr) async{
setState(() {
  isLoading = true;
});
    print("qr $qr");
      final docRef = FirebaseFirestore.instance.collection('personalData').doc(qr);
        docRef.get().then((doc){
          print("qr $qr");
            if (doc.exists) {
              setState(() {
                id = doc.data()['id'];
                firstname = doc.data()['firstname'];
                lastname = doc.data()['lastname'];
                gender = doc.data()['gender'];
                mobileno = doc.data()['mobileno'];
                city = doc.data()['city'];
                purok = doc.data()['purok'];
                barangay = doc.data()['barangay'];
                email = doc.data()['email'];
                password = doc.data()['password'];
                age = doc.data()['age'];
              });
              // print(doc);
              setState(() {
                isLoading = false;
              });
              print("doc.data()['firstname'] ${doc.data()['firstname']}");
              print("firstname $firstname");
            } else {
              // doc.data() will be undefined in this case
              print("No such documents!");
            }
      });
  }
  getEstablishment() async{
    setState(() {
      isLoading = true;
    });
    final docRef1 = FirebaseFirestore.instance
        .collection('establishmentData')
        .doc(widget.username);
    docRef1.get().then((doc){
        if (doc.exists) {
          password = doc.data()['password'];
          if(password == widget.password){
            establishment_name = doc.data()['establishmentname'];
            establishmentaddress = doc.data()['establishmentaddress'];
            setState(() {
              isLoading = false;
            });
            print(doc.data()['establishmentname']);
          }
          if(widget.password != password){
            print('wrong password !');
            //isLoading = false;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Your Password is Wrong'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                         //Navigator.of(context).pop();
                        Navigator.pushNamed(context, SignUpEstablishment.id);
                      },
                    ),
                  ],
                );
              },
            );
          }
          // print(doc);
          // print(doc.data()['establishmentname']);
        }
       else {
        // doc.data() will be undefined in this case
          setState(() {
            isLoading = true;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Your Username is Wrong'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        //Navigator.of(context).pop();
                        Navigator.pushNamed(context, SignUpEstablishment.id);
                      },
                    ),
                  ],
                );
              },
            );
           // Navigator.of(context).pop();
          });
        print("No such document");
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEstablishment();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        actions: [
          FlatButton(
            child: Text('',style: TextStyle(
              color: Colors.white,
            ),),
            onPressed: (){
              return Navigator.pushNamed(context, SignUpEstablishment.id);
            },
          )
        ],
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[900],
        title: Text("Scanner"),
        centerTitle: true,
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
                           backgroundImage: AssetImage('images/scan.jpg'),
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(child: Text(widget.username,style: TextStyle(fontSize: 18 , color: Colors.white),)),
                    // Center(child: Text('$email',style: TextStyle(fontSize: 16 , color: Colors.white),))
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: (){
                // return Navigator.pushNamed(context, UpdateData.id);
                return Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ViewallScanned(widget.username,)));
              },
            ),
            //SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: ()async{
                setState(() async{
                  //await fAuth.signOut();
                  return Navigator.pushNamed(context, Welcome.id);
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child:
          isLoading ? Center(child:CircularProgressIndicator()) :
          Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "${widget.username}",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,color: Colors.white),
                textAlign: TextAlign.center,
              ),
              // Text(
              //   qrCodeResult,
              //   style: TextStyle(
              //     fontSize: 20.0,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "First Name :${firstname == "" || firstname == null ? "" : firstname}" ,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                   ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "Last Name :${lastname == "" || lastname == null ? "" : lastname }",style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                  ),
                ),
              ),
              // Card(
              //   child: ListTile(
              //     title: Text(
              //       "Gender :${gender == "" || gender == null ? "" : gender }",style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.black87,
              //     ),
              //     ),
              //   ),
              // ),
              Card(
                child: ListTile(
                  title: Text(
                    "Age :${age == "" || age == null ? "" : age }",style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                  ),
                ),
              ),
              // Card(
              //   child: ListTile(
              //     title: Text(
              //       "Contact No. :${mobileno == "" || mobileno == null ? "" : mobileno }",style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.black87,
              //     ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20.0,
              ),
              // RoundedButton(
              //   title: 'View Scanned',
              //   colour: Colors.deepOrange,
              //   onPressed: () {
              //
              //       return Navigator.of(context).push(
              //           MaterialPageRoute(builder: (context)=>ViewallScanned(widget.username,)));
              //   },
              // ),
              RoundedButton(
                title: 'Scan',
                colour: Colors.deepOrange,
                onPressed: () async{
                  String codeScanner = await BarcodeScanner.scan(); //barcode scanner
                  setState(() {
                    qrCodeResult = codeScanner;
                    if (qrCodeResult.isEmpty) {        //a little validation for the textfield
                      setState(() {
                        qrData = "";
                      });
                    } else {
                      getUser(qrCodeResult);
                      setState(() {
                        qrData = qrCodeResult;
                      });
                    }

                  });

                },
              ),

              // RaisedButton(
              //   color: Colors.deepOrange,
              //   padding: EdgeInsets.all(15.0),
              //   onPressed: () async {
              //     String codeScanner = await BarcodeScanner.scan(); //barcode scanner
              //     setState(() {
              //       qrCodeResult = codeScanner;
              //       if (qrCodeResult.isEmpty) {        //a little validation for the textfield
              //         setState(() {
              //           qrData = "";
              //         });
              //       } else {
              //         getUser(qrCodeResult);
              //         setState(() {
              //           qrData = qrCodeResult;
              //         });
              //       }
              //     });
              //   },
              //   child: Text(
              //     "Open Scanner",
              //     style:
              //     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              //   ),
              //   // shape: RoundedRectangleBorder(
              //   //     side: BorderSide(color: Colors.deepOrange, width: 3.0),
              //   //     borderRadius: BorderRadius.circular(20.0)),
              // ),
              RoundedButton(
                title: 'Save',
                colour: Colors.deepOrange,
                onPressed: () {
                  //
                  print(firstname);
                  print(email);
                  //print(password);
                  setState(() {

                    DateTime now = new DateTime.now();

                    String formattedDate = DateFormat('yyyy-MM-dd – hh:mm a'). format(now);
                    firestore.collection(widget.username).doc(uid).set({
                      'firstname':firstname,
                      'establishmentusername':widget.username,
                      'lastname':lastname,
                      'gender':gender,
                      'city':city,
                      'barangay':barangay,
                      'age':age,
                      'email':email,
                      'mobileno':mobileno,
                      'purok':purok,
                      'id':id,
                      'now':formattedDate,
                    });
                  });
                  print("$firstname");
                  setState(() {
                    if(firstname==firstname&& now==now){
                      print(establishment_name);
                    }
                  });

                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Column(
                        children: [
                          // Text('IMPORTANT!!!Who should register for Establishment?'),
                          SizedBox(height: 20.0,
                          ),
                          Center(
                            child: Text('Successfully Saved !',
                              style: TextStyle(

                              ),),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            FlatButton(
                              child: Text('continue',style: TextStyle(
                                color: Colors.deepOrange,
                              ),),
                              onPressed: () async{
                                Navigator.of(context).pop();
                                //Navigator.pushNamed(context, Scanner.id);
                                String codeScanner = await BarcodeScanner.scan(); //barcode scanner
                                setState(() {
                                  qrCodeResult = codeScanner;
                                  if (qrCodeResult.isEmpty) {        //a little validation for the textfield
                                    setState(() {
                                      qrData = "";
                                    });
                                  } else {
                                    getUser(qrCodeResult);
                                    setState(() {
                                      qrData = qrCodeResult;
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  });

                },
              ),
              // SizedBox(height :20.0),
              // RaisedButton(
              //   color: Colors.deepOrange,
              //   padding: EdgeInsets.all(15.0),
              //   child: Text('Save',style: TextStyle(color: Colors.white),
              //   ),
              //   onPressed: ()async{
              //     print(firstname);
              //     print(email);
              //     print(password);
              //     setState(() {
              //       DateTime now = new DateTime.now();
              //       String formattedDate = DateFormat('yyyy-MM-dd – hh:mm a'). format(now);
              //
              //       firestore.collection('userScanned').doc(uid).set({
              //         'firstname':firstname,
              //         'establishmentusername':widget.username,
              //         'lastname':lastname,
              //         'gender':gender,
              //         'address':address,
              //         'now':formattedDate,
              //       });
              //     });
              //     print("$firstname");
              //   }
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
