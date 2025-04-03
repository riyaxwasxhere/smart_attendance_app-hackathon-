import 'package:flutter/material.dart';
import 'package:frontend/layout.dart';
import 'package:google_fonts/google_fonts.dart';

final kcolorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: kcolorScheme,
        textTheme: GoogleFonts.latoTextTheme(),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorScheme.primary,
        ),
      ),
      home: const Layout(),
    ),
  );
}
