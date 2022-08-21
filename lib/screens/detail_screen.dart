import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile5/style/list_tile_style.dart';
import 'package:mobile5/widgets/app_bar_styled.dart';
import 'package:mobile5/widgets/floating_action_button_camera.dart';
import 'package:mobile5/models/post.dart';
import 'dart:io';

class Details extends StatelessWidget {
  Details({Key? key, required this.post}) : super(key: key);
  Post post;
  final String theTitle = "Wasteagram";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 213, 248, 251),
          appBar: AppBar(
            leading: Semantics(
              button: true,
              onTapHint: 'back button to previous page',
              child: IconButton(
                  icon: const Icon(Icons.arrow_circle_left),
                  onPressed: (() {
                    Navigator.pop(context);
                  })),
            ),
            title: Text(
              theTitle,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: "Bebas Neue",
                color: Color.fromARGB(255, 222, 141, 193),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 9, 45, 50),
          ),
          body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(post.date, style: theStyle(35))),
              Center(
                  child: Semantics(
                image: true,
                hint: "displays image of food waste from selected day.",
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 450),
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 189, 178, 30),
                        width: 8),
                  ),
                  child: Image.network(post.url),
                ),
              )),
              Semantics(
                hint: "displays numbers of items wasted.",
                child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text("Items Wasted: ${post.waste.toString()}",
                        style: theStyle(25))),
              ),
              Semantics(
                hint: "display corrdinates of location when item was posted",
                child: Text(
                  post.location,
                  style: theStyle(20),
                ),
              )
            ],
          )),
    );
  }
}

TextStyle theStyle(double size) {
  return TextStyle(
    fontFamily: "YanoneKaffeesatz",
    fontSize: size,
    color: const Color.fromARGB(255, 222, 141, 193),
  );
}
