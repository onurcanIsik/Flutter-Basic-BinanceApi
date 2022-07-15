import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

Widget coinWidget(String title, String image) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 70,
      child: Card(
        shadowColor: HexColor("#E8AB16"),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: HexColor("#E7E1E0"),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: 30,
              minRadius: 20,
              backgroundImage: AssetImage(image),
            ),
            title: Text(
              title,
              style: GoogleFonts.baloo2(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
