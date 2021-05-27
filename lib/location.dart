import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:project/model/userlocation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shortid/shortid.dart';
import 'package:intl/intl.dart';
class LocationService{

  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading;
  String currentUserID;
  String id;
  String firstname,currentPosition,firstnametemp,firstnamet,lastname,establishment_name='Robinsons';
  double lat,long;
  DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
  int _counter = 0;
  String name;
  final userRef =FirebaseFirestore.instance.collection('personalData');
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  getUser() async{
    final docRef = FirebaseFirestore.instance
        .collection('personalData')
        .doc(loggedInUser.uid);
    print(currentUserID);
    docRef.get().then((doc){
      if (doc.exists) {
        firstnamet = doc.data()['firstname'];
        // currentPosition = doc.data()['currentPosition'].toString();
        // print(doc.data()['firstname']);
        // print('Current Position:${doc.data()['currentPosition']}');
        // final coord = currentPosition.split(",");
        // final coordLat = coord[0].replaceAll('[', "");
        // final coordLong = coord[1].replaceAll("]", "");
        // lat = double.parse(coordLat);
        // long = double.parse(coordLong);

      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
  }
  void getCurrentUser() async {
    isLoading = true;
    try{
      final user = await auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        currentUserID = loggedInUser.uid;
        isLoading = false;
        getUser();
      }
    }catch(e){
      print(e);
    }
  }
  // getEstablishment() async{
  //   final docRef1 = FirebaseFirestore.instance
  //       .collection('establishmentData')
  //       .doc('Robinsons');
  //   docRef1.get().then((doc){
  //     if (doc.exists) {
  //         establishment_name = doc.data()['establishmentname'];
  //         print(doc.data()['establishmentname']);
  //     }
  //   });
  // }
  getOtherUserCoord()async{
    await userRef.get().then((QuerySnapshot snapshot){
      snapshot.docs.forEach((DocumentSnapshot docx) {
        //firstname = docx.data()['firstname'];
        firstnametemp = docx.data()['firstname'];
        currentPosition = docx.data()['currentPosition'].toString();
        print(docx.data()['firstname']);
        print('Current Position:${docx.data()['currentPosition']}');
        final coord = currentPosition.split(",");
        final coordLat = coord[0].replaceAll('[', "");
        final coordLong = coord[1].replaceAll("]", "");
        //TODO: PUT TRAPPING
        lat = double.parse(coordLat);
        long = double.parse(coordLong);
        print('$firstname $lat $long');

      });
    });
  }


  //keep track current location
  UserLocation _currentLocation;
  Location location = Location();
  //continuesly emit location update
  StreamController<UserLocation> _locationController=
  StreamController<UserLocation>.broadcast();
  LocationService(){
    getCurrentUser();
    location.requestPermission().then((granted){
      if(granted !=null){
        location.onLocationChanged.listen((locationData){
          if(locationData!=null)
            _locationController.add(UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude,
            ));
          //for update checking uncomment
          // print("update ${locationData.latitude}");

         userRef.get().then((QuerySnapshot snapshot){
            snapshot.docs.forEach((DocumentSnapshot docx) {
              firstname = docx.data()['firstname'];
              lastname = docx.data()['lastname'];
              currentPosition = docx.data()['currentPosition'].toString();
              // print(docx.data()['firstname']);
              // print('Current Position:${docx.data()['currentPosition']}');
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
             // print('other user $firstname $lat $long');
              //change 4 for distance (i.e 2 = very near, 1 super near , 0 = you)
              double distance = calculateDistance(locationData.latitude, locationData.longitude, lat, long);
              if( distance < 0.0002 &&
                  distance != 0.0){
                //KRIS distance is 3.6982327967831345
                print(' $firstname ${_counter+1} $distance  is  Near');
                print('$currentPosition');
                //PUT YOUUR NOTIFICATION CODE
               // for(int i=0;distance<0.002;i++){
                  FlutterLocalNotificationsPlugin localNotifications = new FlutterLocalNotificationsPlugin();
                  var androidInitialize = new  AndroidInitializationSettings('@mipmap/ic_launcher');
                  var iOsInitialize = new IOSInitializationSettings();
                  var initializationSettings = new InitializationSettings(android: androidInitialize, iOS: iOsInitialize);
                  localNotifications = new FlutterLocalNotificationsPlugin();
                  localNotifications.initialize(initializationSettings);
                  var androidDetails = new AndroidNotificationDetails('channelId', 'Local Notification', 'this is the description of the notification',importance: Importance.high);
                  var iOSDetails = new IOSNotificationDetails();
                  var generalNotification = new NotificationDetails(android: androidDetails,iOS: iOSDetails);
                  localNotifications.show(0, 'Notification ${_counter++}','  $firstnamet  and $firstname $lastname are  Violating 2 meters Physical Distance', generalNotification);

                  // List<String>splitList = name.split(' ');
                  // List<String> indexList= [];
                  //
                  // for(int i=0;i<splitList.length;i++){
                  //   for(int y=1;y <splitList[i].length+1;i++){
                  //     indexList.add(splitList[i].substring(0,y).toLowerCase());
                  //   }
                  //
                  // }
                  DateTime now = new DateTime.now();
                 // print(establishment_name);
                  String formattedDate = DateFormat('yyyy-MM-dd – hh:mm a'). format(now);
                  String id=shortid.generate();
                  _firestore.collection('notifyReport').doc(id).set({
                    'firstname1':firstname.toUpperCase(),
                    'firstname2':firstnamet.toUpperCase(),
                    'establishment1':establishment_name,
                    // 'searchIndex':indexList,
                    'now':formattedDate,
                  });
                //}
              }
            });
          });
            //firebase update
          _firestore.collection('personalData').doc(currentUserID).update({
            // 'id':user.uid,
            'currentPosition':[locationData.latitude,locationData.longitude],
          });
          //TODO : CREATE UPDATE FOR OTHER USER
        });
      }
    });
  }
  Stream<UserLocation> get locationStream => _locationController.stream;
  Future<UserLocation> getLocation() async {
    try{
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
          latitude: userLocation.latitude,
          longitude: userLocation.longitude);
    }catch(e){
      print('Could not get the location : $e');
    }
    return _currentLocation;
  }
}






















