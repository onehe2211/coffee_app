import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customFooter(String title,Function press){
  return GestureDetector(
    onTap: (){
      press();
    },
    child: Text(title,style: GoogleFonts.play(
      fontSize: 18,
    ),),
  );
}