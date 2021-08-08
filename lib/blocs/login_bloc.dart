import 'dart:async';

import 'package:coffee_app01/services/auth_service.dart';


class LoginBloc {
  AuthService _authService =new AuthService();
  StreamController _userNameController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passwordController = new StreamController();

  Stream get userNameStream => _userNameController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passwordStream => _passwordController.stream;

  bool isValid(String userName, String phone, String email, String password) {
    if (userName.isEmpty || userName.length <= 4) {
      _userNameController.sink
          .addError("User name isn't empty and length min is 4");
      return false;
    }
    _userNameController.sink.add("");

    if (email.isEmpty || !email.contains("@")) {
      _emailController.sink.addError("Email isn't empty or wrong");
      return false;
    }
    _emailController.sink.add("");

    if (phone.isEmpty || phone.length != 10) {
      _phoneController.sink
          .addError("Phone isn't empty or not enough 10 numbers");
      return false;
    }
    _phoneController.sink.add("");

    if (password.isEmpty || password.length <6) {
      _passwordController.sink
          .addError("Password isn't empty or not enough 6 chars");
      return false;
    }
    _passwordController.sink.add("");

    return true;
  }

  void loginAccount(String email,String password, Function onSuccess,Function(String) onError){
    _authService.loginWithEmailAndPassword(email, password, onSuccess, onError);
  }

  void registerAccount(String userName,String email,String phone,String password,Function onSuccess,Function(String) onError){
    _authService.registerWithEmailAndPassword(userName, email, phone, password, onSuccess, onError);
  }
  void googleSign(Function onSuccess,Function(String) onError){
    _authService.googleSignIn(onSuccess, onError);
  }

  void facebookSign(Function onSuccess,Function(String) onError){
    _authService.faceBookSignIn(onSuccess, onError);
  }
  void anonymounsSign(Function onSuccess,Function(String) onError){
    _authService.anonymounsSignIn(onSuccess, onError);
  }

  void signOutAccount(Function onSuccess){
    _authService.signOut(onSuccess);
  }
  void signOutGoogle(Function onSuccess){
    _authService.googleSignOut(onSuccess);
  }
  void signOutFacebook(Function onSuccess){
    _authService.facebookSignOut(onSuccess);
  }
  void sendPasswordToEmail(String email,Function onSuccess,Function(String) onError){
    _authService.sendPasswordResetEmail(email, onSuccess, onError);
  }
  void dispose(){
    _userNameController.close();
    _passwordController.close();
    _emailController.close();
    _phoneController.close();
  }
}
