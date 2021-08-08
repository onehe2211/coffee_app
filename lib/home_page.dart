
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app01/components/custom_card.dart';
import 'package:coffee_app01/dialogs/error_dialog.dart';
import 'package:coffee_app01/login_page.dart';
import 'package:coffee_app01/services/auth_service.dart';
import 'package:coffee_app01/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService _authService = new AuthService();
  CloudDatabase _cloudDatabase = new CloudDatabase();
  @override
  void initState() {
    _authService.getUserId();
    _cloudDatabase.getUserName(_authService.getUserId());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){},
          icon:  Icon(Icons.menu),
        ),
        title: StreamBuilder(
          stream: _cloudDatabase.userNameStream,
          builder: (context, snapshot) {
            return Text("Welcome ${snapshot.data}");
          }
        ),
        actions: [
          IconButton(
              onPressed: () {
                _authService.signOut(() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _cloudDatabase.productRef.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return ErrorDialog.showErrorDialog(
                  context, "Error", snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.count(
              crossAxisCount: 1,
              childAspectRatio: (3/4),
              children: snapshot.data!.docs.map((DocumentSnapshot document){
                Map<String,dynamic> data= document.data() as Map<String,dynamic>;
                return CustomCard(data: data);
              }).toList(),
            );
          }),
    );
  }

  void onGoogleSignOut() {
    _authService.googleSignOut(() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  void onFBSignOut() {
    _authService.facebookSignOut(() {
      setState(() {
        ErrorDialog.showErrorDialog(context, "LOGOUT", "Connect");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      });
    });
  }
}
