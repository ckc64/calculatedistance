import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//final userRef =FirebaseFirestore.instance.collection('Robinsons1');
import 'viewscanned.dart';
String firstname='no value',lastname ='no value';
String now='no value';
String establishmentusername;
String id;
class ViewallScanned extends StatefulWidget {
  static const String id = 'viewallscanned';
  final String username;
  ViewallScanned(this.username,);
  @override
  _ViewallScannedState createState() => _ViewallScannedState();
}
class _ViewallScannedState extends State<ViewallScanned> {
  bool isLoading = false;

  getUsersScanned()async{
    final userRef =FirebaseFirestore.instance.collection(widget.username);
    await userRef.get().then((QuerySnapshot snapshot){
      snapshot.docs.forEach((DocumentSnapshot docx) {
        setState(() {
          id = docx.data()['id'];
          firstname = docx.data()['firstname'];
          lastname = docx.data()['lastname'];
          establishmentusername = docx.data()['establishmentusername'];
          now = docx.data()['now'].toString();
          print(id);
          print(firstname);
          print(now);
          print('Time that User\'s Scanned:${docx.data()['now']}');
        });

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsersScanned();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[900],
        title: Text('View All Scanned'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(widget.username).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Text('no value');
          }
          return ListView(
            children: snapshot.data.docs.map((docx){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                children: [
                  Container(padding: EdgeInsets.fromLTRB(20,30,20,20),child: Text(docx['firstname'],style: TextStyle(color: Colors.white, fontSize: 15),)),
                  Container(padding: EdgeInsets.fromLTRB(30,30,34,20),child: Text(docx['lastname'],style: TextStyle(color: Colors.white, fontSize: 15),)),
                  Container(padding: EdgeInsets.fromLTRB(20,30,20,20), child: Text(docx['now'],style: TextStyle(color: Colors.white, fontSize: 15),)),
                ],
              );
            }).toList(),
          );
        },
      ),
      // body:  isLoading ? Center(
      //   child: CircularProgressIndicator(
      //     backgroundColor: Colors.lightBlueAccent,
      //   ),
      // ) : SingleChildScrollView(
      //     child: Column(
      //       children: [
      //       FlatButton(
      //                  color: Colors.blueGrey[900],
      //                  padding: EdgeInsets.all(30.0),
      //                  onPressed: () {
      //                    return Navigator.of(context).push(
      //                        MaterialPageRoute(builder: (context)=>ViewScanned(id,)));
      //                  },
      //                  child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                    mainAxisSize: MainAxisSize.max,
      //                    children: [
      //                      Text(
      //                        '$firstname',
      //                        style: TextStyle(color: Colors.white, fontSize: 15),
      //                      ),
      //                      Text(
      //                        '$lastname',
      //                        style: TextStyle(color: Colors.white, fontSize: 15),
      //                      ),
      //                      Text(
      //                        '$now',
      //                        style: TextStyle(color: Colors.white, fontSize: 15),
      //                      ),
      //                    ],
      //                  ),
      //                ),
      //       ],
      //     ),
      // ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     //SizedBox(height: 5,),
      //     //Text('fistname'),
      //          FlatButton(
      //            color: Colors.blueGrey[500],
      //            padding: EdgeInsets.all(30.0),
      //            onPressed: () {
      //              return Navigator.of(context).push(
      //                  MaterialPageRoute(builder: (context)=>ViewScanned(id,)));
      //            },
      //            child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //              mainAxisSize: MainAxisSize.max,
      //              children: [
      //                Text(
      //                  '$firstname',
      //                  style: TextStyle(color: Colors.white, fontSize: 15),
      //                ),
      //                Text(
      //                  '$lastname',
      //                  style: TextStyle(color: Colors.white, fontSize: 15),
      //                ),
      //                Text(
      //                  '$now',
      //                  style: TextStyle(color: Colors.white, fontSize: 15),
      //                ),
      //              ],
      //            ),
      //          ),
      //   ],
      // ),
    );
  }
}
