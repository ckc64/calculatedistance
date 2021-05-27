import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/model/user.dart';
import 'package:project/services/database.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    final User user = await auth.currentUser;
    final String uid = user.uid;
    return uid;
  }
  //create user obj base on firebase
  Users userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //Stream
  Stream<Users> get user {
    return auth.idTokenChanges()
        .map((User user) => userFromFirebaseUser(user));
  }


  //signin anon
  Future signUpAnon() async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User user = result.user;
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }

  }
  //signup
  Future signUpWithEmailandPassword(String email,String password) async{
    try{
      UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return userFromFirebaseUser(user);
    }catch(e){
      print(toString());
      return null;
    }
  }
  //register with email and password
  Future registerWithEmailandPassword(String email,String password) async{
    try{
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //create a new document for the user with the uid
      //await DatabaseService(uid: user.uid).updateUserData('rue', 'alforte', 'male', '','','');
      return userFromFirebaseUser(user);
    }catch(e){
      print(toString());
      return null;
    }
  }
  //sing out
  Future signOut() async {

    try{
        return await auth.signOut();
    }catch(e){
      print(toString());
      return null;
    }
  }
}
