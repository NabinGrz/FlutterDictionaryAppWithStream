import 'package:dictionaryapp/dictionary-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      home: const MyApp(),
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DictionaryPage();
  }
}
