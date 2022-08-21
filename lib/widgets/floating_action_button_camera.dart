import 'package:flutter/material.dart';
import 'package:mobile5/screens/new_post.dart';

class FabForCamera extends StatelessWidget {
  FabForCamera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.all(10.0),
        child: Semantics(
          button: true,
          onLongPressHint: "Takes you to camera gallery to select a picture",
          child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 9, 45, 50),
              splashColor: const Color.fromARGB(255, 222, 141, 193),
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewPost()));
              }),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Color.fromARGB(255, 222, 141, 193),
              )),
        ));
  }
}
