import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firestore.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CloudDatabase _cloudDatabase = new CloudDatabase();
  FacebookLogin _fbLogin = new FacebookLogin();
  GoogleSignIn _googleSign = GoogleSignIn(scopes: ['email']);

  String getUserId() {
    return _auth.currentUser!.uid;
  }

  Future<void> sendPasswordResetEmail(
      String email, Function onSuccess, Function(String) onError) async {
    _auth
        .sendPasswordResetEmail(email: email)
        .whenComplete(() => onSuccess())
        .catchError((error) {
      onError("Error is: " + error.code);
    });
  }


  void registerWithEmailAndPassword(String username, String email, String phone,
      String password, Function onSuccess, Function(String) onError) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .whenComplete(() => _cloudDatabase.createUser(
            getUserId(), username, phone, onSuccess, onError))
        .catchError((error) => onError("Error is: " + error.code));
  }

  void loginWithEmailAndPassword(String email, String password,
      Function onSuccess, Function(String) onError) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .whenComplete(() => onSuccess())
        .catchError((error) => onError("Error is: " + error.code));
  }
  void signOut(Function onSuccess){
    _auth.signOut().whenComplete(() => onSuccess());
  }

  void googleSignIn(Function onSuccess, Function(String) onError) async {
    await _googleSign
        .signIn()
        .whenComplete(() => onSuccess())
        .catchError((error) => onError("Error is: " + error.code));
  }

  void googleSignOut(Function onSuccess) {
    _googleSign.signOut().whenComplete(() => onSuccess());
  }

  void faceBookSignIn(Function onSuccess, Function(String) onError) async {
    await _fbLogin
        .logIn(['public_profile', 'email'])
        .whenComplete(() => onSuccess())
        .catchError((error) => onError("FB Error: " + error.code));
  }

  void facebookSignOut(Function onSuccess) async {
    await _fbLogin.logOut().whenComplete(() => onSuccess());
  }

  void anonymounsSignIn(Function onSuccess, Function(String) onError) async {
    await _auth
        .signInAnonymously()
        .whenComplete(() => onSuccess())
        .catchError((error) => onError("Error is:" + error.code));
  }
}
