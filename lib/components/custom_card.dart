import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,1),
            blurRadius: 1,
            color: Colors.white.withOpacity(0.6),
          )
        ]
      ),
      child: Card(
        color: Colors.white,
        shadowColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.contain,
                    image: NetworkImage(data['image']))),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Container(
                  height: 40,
                  child: Text(data['name'],
                    style: GoogleFonts.play(
                      fontSize: 25,
                    ),)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${data['price']} VND',
                  style: GoogleFonts.play(
                    fontSize: 20,
                  ),
                ),
                Icon(Icons.favorite_border)
              ],
            ),
          ],
        ),
      ),
    );
  }
}