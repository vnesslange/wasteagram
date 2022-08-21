import 'package:flutter/material.dart';
import 'package:mobile5/screens/camera_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 213, 248, 251),
            appBar: AppBar(
              title: const Text(
                "Wasteagram",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Bebas Neue",
                  color: Color.fromARGB(255, 222, 141, 193),
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 9, 45, 50),
            ),
            body: CameraScreen()));
  }
}
