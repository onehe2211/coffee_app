import 'package:coffee_app01/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';
import 'components/custom_button.dart';
import 'components/custom_footer.dart';
import 'register_page.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 163, 36, 2),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/a1.jpg'),
          Text(
            "COFFEE APP",
            style: GoogleFonts.aladin(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
          customButton("Login", () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          }),
          customButton("Register", () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => RegisterPage()));
          }),
          SizedBox(
            height: 100,
          ),
          customFooter("co.Avengers", () {
            ErrorDialog.showErrorDialog(context, 'Team Avengers',
                'ĐỖ QUANG HUY \nLÊ MINH TOÀN \nNGUYỄN PHÚ HUY\nTRẦN NGUYỄN DÂN\nPHẠM PHÚ MINH NHẬT\nPHAN TRUNG HIẾU\nĐẶNG MINH TÍNH');
          })
        ],
      ),
    );
  }
}
