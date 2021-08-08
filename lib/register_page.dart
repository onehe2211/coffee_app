import 'package:coffee_app01/dialogs/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'blocs/login_bloc.dart';
import 'components/custom_button.dart';
import 'components/custom_footer.dart';
import 'constant.dart';
import 'dialogs/error_dialog.dart';
import 'dialogs/loading_dialog.dart';
import 'home_page.dart';
import 'login_page.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  LoginBloc _bloc =new LoginBloc();
  TextEditingController _userNameController= new TextEditingController();
  TextEditingController _emailController= new TextEditingController();
  TextEditingController _phoneController= new TextEditingController();
  TextEditingController _passwordController= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Text("Welcome to",style: GoogleFonts.play(
                    fontSize: 18,
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 10),
                    child: Text("REGISTER",style: kHeadingTextFont,),
                  ),
                ],
              ),
              CustomTextField(controller: _userNameController, bloc: _bloc.userNameStream, label: "UserName", iconData: Icons.person),
              CustomTextField(controller: _emailController, bloc: _bloc.emailStream, label: "Email", iconData: Icons.email_outlined),
              CustomTextField(controller: _phoneController, bloc: _bloc.phoneStream, label: "Phone", iconData: Icons.phone),
              CustomTextField(controller: _passwordController, bloc: _bloc.passwordStream, label: "Password", iconData: Icons.password),
              customButton("REGISTER", (){
                onRegClick();
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: customFooter("You don't have account? Create new account!", () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()));
        }),
      ),
    );
  }

  void onRegClick(){
    var userName =_userNameController.text;
    var email =_emailController.text;
    var phone =_phoneController.text;
    var password =_passwordController.text;
    if(_bloc.isValid(userName, phone, email, password)){
      LoadingDialog.showLoadingDialog(context, "Loading...");
      _bloc.registerAccount(userName, email, phone, password, (){
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
      }, (error) {
        LoadingDialog.hideLoadingDialog(context);
        ErrorDialog.showErrorDialog(context, "Error Register", error);
      });
    }
  }
}
