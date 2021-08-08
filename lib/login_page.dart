import 'package:coffee_app01/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'blocs/login_bloc.dart';
import 'components/custom_button.dart';
import 'components/custom_footer.dart';
import 'constant.dart';
import 'dialogs/error_dialog.dart';
import 'dialogs/loading_dialog.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _bloc = new LoginBloc();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool passwordShow =true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Text(
                "Welcome to",
                style: GoogleFonts.play(
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10),
                child: Text(
                  "LOGIN",
                  style: kHeadingTextFont,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Enter in here",
                labelText: "Email",
                labelStyle: GoogleFonts.play(fontSize: 20),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: passwordShow,
                  decoration: InputDecoration(
                    hintText: "Enter in here",
                    labelText: "Password",
                    labelStyle: GoogleFonts.play(fontSize: 20),
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: (){
                      setState(() {
                        passwordShow=!passwordShow;
                      });
                    },
                    child: Text(passwordShow? "show":"hide")),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              customFooter("Forgot password ?", () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgotPassword()));
              }),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: customButton("LOGIN", () {
                  onLoginWithEmailAndPass();
                }),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Text("Or"),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: 300,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          onAnonySign();
                        },
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          onFacebookSign();
                        },
                        child: Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 50,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            onGoogleSign();
                          });
                        },
                        child: Image.asset(
                          'assets/images/a2.png',
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //SizedBox(height: 80,),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: customFooter("You don't have account? Create new account!", () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegisterPage()));
        }),
      ),
    );
  }

  void onLoginWithEmailAndPass() {
    var email = _emailController.text;
    var password = _passwordController.text;
    LoadingDialog.showLoadingDialog(context, "Loading...");
    _bloc.loginAccount(email, password, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (error) {
      LoadingDialog.hideLoadingDialog(context);
      ErrorDialog.showErrorDialog(context, "Error Login", error);
    });
  }

  void onGoogleSign() {
    LoadingDialog.showLoadingDialog(context, "Loading...");
    _bloc.googleSign(() {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (error) {
      LoadingDialog.hideLoadingDialog(context);
      ErrorDialog.showErrorDialog(context, "Error", error);
    });
  }

  void onFacebookSign() {
    LoadingDialog.showLoadingDialog(context, "Loading...");
    _bloc.facebookSign(() {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (error) {
      LoadingDialog.hideLoadingDialog(context);
      ErrorDialog.showErrorDialog(context, "Error", error);
    });
  }

  void onAnonySign() {
    LoadingDialog.showLoadingDialog(context, "Loading...");
    _bloc.anonymounsSign(() {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (error) {
      LoadingDialog.hideLoadingDialog(context);
      ErrorDialog.showErrorDialog(context, "Error", error);
    });
  }
}
