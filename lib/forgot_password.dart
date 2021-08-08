import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constant.dart';
import 'blocs/login_bloc.dart';
import 'dialogs/error_dialog.dart';
import 'dialogs/loading_dialog.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginBloc _bloc =LoginBloc();
    TextEditingController _emailController =new TextEditingController();
    return  AlertDialog(
      title: Text("FORGOT PASSWORD",style: GoogleFonts.play(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Text("Enter email to sending the password",style: GoogleFonts.play(
              fontSize: 20,
            ),),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle:  GoogleFonts.play(
                  fontSize: 20,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(onPressed: (){
          var email = _emailController.text;
          LoadingDialog.showLoadingDialog(context, "Sending...");
          _bloc.sendPasswordToEmail(email, (){
            LoadingDialog.hideLoadingDialog(context);
          }, (error) {
            LoadingDialog.hideLoadingDialog(context);
            ErrorDialog.showErrorDialog(context, "error", error);
          });
        }, child: Text("SEND")),
        FlatButton(onPressed: (){
          Navigator.of(context).pop(ForgotPassword());
        }, child: Text("CANCER")),
      ],
    );
  }

}


