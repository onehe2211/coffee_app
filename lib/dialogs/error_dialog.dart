import 'package:flutter/material.dart';

class ErrorDialog{
  static showErrorDialog(BuildContext context,String title,String message){
    showDialog(context: context, builder: (context)=>new AlertDialog(
      content: Text(message),
      title: Text(title),
      actions: [
        FlatButton(onPressed: (){
          Navigator.of(context).pop(ErrorDialog());
        }, child: Text("OK"))
      ],
    ));
  }
}