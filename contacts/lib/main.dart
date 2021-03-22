import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        brightness: Brightness.dark,
        accentColor: Colors.cyan[600],
        primaryColor: Color(0xFF79AAEE),
        backgroundColor: Color(0xFF363636),
      ),
      home: HomePage(),
    );
  }
}
