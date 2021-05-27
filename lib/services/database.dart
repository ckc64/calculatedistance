import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/autheticate/register.dart';
import 'package:project/model/scanned.dart';
import 'package:project/tifier/scannedtifier.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference PersonalDataCollection = FirebaseFirestore.instance.collection('personalData');
  Future updateUserData(String firstname, String lastname,String gender ,String contactnumber,String Address,String age,String currentPosition,String email,String password) async{
    return await PersonalDataCollection.doc(uid).set({
      'firstname':firstname,
      'lastname':lastname,
      'gender':gender,
      'mobileno':contactnumber,
      'email':email,
      'password':password,
      'currentPosition':currentPosition,
      'address':Address},);
  }
  // Stream<QuerySnapshot> get personalinfo{
  //   return PersonalDataCollection.snapshots();
  // }
//   Future getUserData()async{
//     List itemList =[];
//     try{
//       await PersonalDataCollection.get().then((querySnapshot){
//         querySnapshot.docs.forEach((element) {
//           itemList.add(element.data);
//         });
//       });
//       return itemList;
//     }catch(e){
//
//     }
//
// }

}
