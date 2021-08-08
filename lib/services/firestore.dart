import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';


class CloudDatabase{
  CollectionReference _userRef =FirebaseFirestore.instance.collection('Users');
  CollectionReference productRef =FirebaseFirestore.instance.collection('Products');

  void createUser(String userId,String username,String phone,Function onSuccess,Function(String) onError){
    var userInform={'userName': username, 'phone': phone};
    _userRef.doc(userId).set(userInform).then((value) => onSuccess()).catchError((error)=>onError("Error is: "+error.code));
  }
  StreamController _userNameController =new StreamController();
  Stream get userNameStream => _userNameController.stream;
  
  void getUserName(String userId) async {
    _userRef.doc(userId).get().then((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
       _userNameController.sink.add(data['userName']);
    });
  }
}