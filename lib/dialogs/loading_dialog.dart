import 'package:flutter/material.dart';


class LoadingDialog{
  static void showLoadingDialog(BuildContext context,String title){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=>new Dialog(
        child: Container(
          width: 50,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/a3.png'),width: 80,),
                  CircularProgressIndicator()
                ],
              ),
              LinearProgressIndicator(),
            ],
          ),
        ),
    ));
  }
  static void hideLoadingDialog(BuildContext context){
    Navigator.of(context).pop(LoadingDialog());
  }
}