import 'package:flutter/material.dart';

@override
PreferredSizeWidget StyledAppBar(String theTitle, context) {
  return AppBar(
    leading: IconButton(
        icon: const Icon(Icons.arrow_circle_left),
        onPressed: (() {
          Navigator.pop(context);
        })),
    title: Text(
      theTitle,
      style: const TextStyle(
        fontSize: 30,
        fontFamily: "Bebas Neue",
        color: Color.fromARGB(255, 222, 141, 193),
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 9, 45, 50),
  );
}
