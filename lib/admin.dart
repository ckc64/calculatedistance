import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Admin extends StatefulWidget {
  static const String id = 'admin';
  final String admin;
  final String password;
  Admin(this.admin,this.password);
  @override
  _AdminState createState() => _AdminState();
}
class _AdminState extends State<Admin> {
  String searchString;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
              ),
            )
          ],
        )),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: (searchString == null || searchString.trim()=='')
                ? FirebaseFirestore.instance.collection('notifyReport').snapshots()
                : FirebaseFirestore.instance.collection('notifyReport')
                .where('searchIndex',arrayContains: searchString).snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasError)
                return Text('Error : ${snapshot.error}');
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(),);
                default :
                  return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot document){
                      return new ListTile(
                        title: new Text(document['establishment1']),
                      );
                    }).toList()
                  );
              }
            },
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              TextField(),Expanded(child: ListView())
            ],
          ),
        )
      ],
    );
  }
}
