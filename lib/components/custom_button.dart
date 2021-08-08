import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
Widget customButton(String text,Function press){
  return GestureDetector(
    onTap: (){
      press();
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 250,
        height: 80,
        alignment: Alignment.center,
        child: Text(text,style: GoogleFonts.play(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.brown.shade100
        ),),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}