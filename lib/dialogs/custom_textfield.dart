import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Stream bloc;
  final String label;
  final IconData iconData;
  const CustomTextField({Key? key, required this.controller, required this.bloc, required this.label, required this.iconData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: StreamBuilder(
          stream: bloc,
          builder: (context, snapshot) {
            return TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter in here",
                labelText: label,
                errorText: snapshot.hasError? snapshot.error.toString(): null,
                labelStyle: GoogleFonts.play(
                    fontSize: 20
                ),
                prefixIcon: Icon(iconData),

              ),
            );
          }
      ),
    );
  }
}
