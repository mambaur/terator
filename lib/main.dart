import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terator/persentations/navbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terator',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:
              GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      home: const Navbar(),
    );
  }
}
