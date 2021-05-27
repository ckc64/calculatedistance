import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:location/location.dart';
import 'package:project/admin.dart';
import 'package:project/autheticate/establishment.dart';
import 'package:project/forgotpassword.dart';
import 'package:project/home.dart';
import 'package:project/login.dart';
// import 'package:project/model/userlocation.dart';
import 'package:project/notification.dart';
import 'package:project/scanner.dart';
import 'package:project/signup.dart';
import 'package:project/signupadmin.dart';
import 'package:project/test.dart';
import 'package:project/tifier/scannedtifier.dart';
import 'package:project/updateData.dart';
import 'package:project/userspicture.dart';
import 'package:project/viewallcoordinates.dart';
import 'package:project/viewallscanned.dart';
import 'package:project/viewscanned.dart';
import 'package:project/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'autheticate/register.dart';
import 'package:project/signupestablishment.dart';
// import 'package:project/location.dart';
import 'package:project/model/userlocation.dart';
import 'homeview.dart';
import 'location.dart';
import 'package:project/model/scanned.dart';
// void main() =>(){
//   runApp(MyApp());
// }

// void main() => runApp(MultiProvider(providers: [
//   ChangeNotifierProvider(
//     create: (context) => Scannedtifier(),
//   ),
// ],child: MyApp(),
// ));

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String s;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (_) => LocationService().locationStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'flutter demo',
        home: HomeView(),
        initialRoute: Welcome.id,
       // initialRoute: ViewAllCoordinates.id,
        routes: {
          ViewTest.id: (context) => ViewTest(''),
          SignUp.id: (context) => SignUp(),
          Register.id: (context) => Register(),
          Scanner.id: (context) => Scanner('',''),
          UpdateData.id: (context) => UpdateData(),
          Home.id: (context) => Home(),
          UserPicture.id: (context) => UserPicture(),
          Forgot.id: (context) => Forgot(),
          Establishment.id: (context) => Establishment(),
          Welcome.id: (context) => Welcome(),
          LoginAs.id: (context) => LoginAs(),
          SignUpEstablishment.id:(context) =>SignUpEstablishment(),
         // GetUserLatLong.id:(context) =>GetUserLatLong(),
          HomeView.id:(context) =>HomeView(),
          ViewAllCoordinates.id:(context) =>ViewAllCoordinates(),
          ViewallScanned.id:(context) =>ViewallScanned(''),
          NotificationApp.id:(context) =>NotificationApp(),
          ViewScanned.id:(context) =>ViewScanned(''),
          Admin.id:(context) =>Admin('',''),
          SignUpAdmin.id:(context) =>SignUpAdmin(),
        },
      ),
    );
  }
}

