import 'package:firebase_auth/firebase_auth.dart';

getUser() async {
 User user = await FirebaseAuth.instance.currentUser;
  return user.uid;
}