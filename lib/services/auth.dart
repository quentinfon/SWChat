import 'package:swchat/models/user.dart';
import 'package:swchat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object
  User _userFromFirebaseUser(FirebaseUser fuser){
    return fuser != null ? User(uid: fuser.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // Sign in anon
  Future signInAnon() async {
    try{

      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser fuser = result.user;

      return _userFromFirebaseUser(fuser);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser fuser = result.user;

      return _userFromFirebaseUser(fuser);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser fuser = result.user;

      //Create a default document for the user
      await DatabaseService(uid: fuser.uid).updateUserData('user', '', '', [{}], []);
      return _userFromFirebaseUser(fuser);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}