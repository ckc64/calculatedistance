import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Notify {
  String establishment1;
  String firstname1;
  String firstname2;
  String now;



  Notify(
     
    
      );

  // formatting for upload to Firbase when creating the Notify
  Map<String, dynamic> toJson() => {
    'establishment1': establishment1,
    'firstname1': firstname1,
    'firstname2': firstname2,
    'now': now,
   
  };

  // creating a Notify object from a firebase snapshot
  Notify.fromSnapshot(DocumentSnapshot snapshot) :
      establishment1 = snapshot['establishment1'],
      firstname1 = snapshot['firstname1'],
      firstname2 = snapshot['firstname2'],
      now = snapshot['now'];
} 