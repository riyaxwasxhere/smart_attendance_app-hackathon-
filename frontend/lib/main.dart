import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/layout.dart';
import 'package:google_fonts/google_fonts.dart';

final kcolorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
