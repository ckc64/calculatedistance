import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/services/database.dart';

 final userRef =FirebaseFirestore.instance.collection('personalData');
 // lat and long here try
double lat;
double long; 
class ViewAllCoordinates extends StatefulWidget {
  static const String id = 'viewallcoordinates';

  @override
  _ViewAllCoordinatesState createState() => _ViewAllCoordinatesState();
}
class _ViewAllCoordinatesState extends State<ViewAllCoordinates> {
  getUsers()async{
    await userRef.get().then((QuerySnapshot snapshot){
      snapshot.docs.forEach((DocumentSnapshot docx) {
        firstname = docx.data()['firstname'];
        currentPosition = docx.data()['currentPosition'].toString();
        print(docx.data()['firstname']);
        print('Current Position:${docx.data()['currentPosition']}');
        final coord = currentPosition.split(",");
        final coordLat = coord[0].replaceAll('[', "");
        final coordLong = coord[1].replaceAll("]", "");
        //TODO: PUT TRAPPING
        // if(currentUserID == userRefID){
        //   firstname = docx.data()['firstname'];
        //   currentPosition = docx.data()['currentPosition'].toString();
        //  break;
        // }
         lat = double.parse(coordLat);
         long = double.parse(coordLong);
         print('$firstname $lat $long');
        print(docx.exists);
      });
    });
  }
  final FirebaseAuth auth= FirebaseAuth.instance;
  bool isLoading;
  User loggedInUser;
  String currentUserID;
  String currentPosition;
  String firstname;
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  // void getusers()async{
  //   final users = await userRef.get();
  //   for(var user in users.docs){
  //     print(user.data);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    // final coord = currentPosition.split(",");
    // var coordinates0 =('latitude:'+coord[0].replaceAll('[', "").trim());
    // var coordinates1 =('latitude:'+coord[1].replaceAll(']', "").trim());
    return Scaffold(
      appBar: AppBar(
        title: Text('View All Coordinates'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(''),
            // Text('$coordinates0'),
            // Text('$coordinates1'),
          ],
        ),
      ),
      // body:   StreamBuilder(
      //   stream: _firestore.collection('personalData').snapshots(),
      //   builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot>snapshot){
      //     if(!snapshot.hasData){
      //       return Text('novalue');
      //     }
      //     return ListView(
      //       children: snapshot.data.docs.map((document){
      //         return Column(
      //           children: [
      //             Text(document['currentPosition'].coord=[0].trim()),
      //           ],
      //         );
      //       }).toList(),
      //     );
      //   },
      // ),
    );
  }
}
