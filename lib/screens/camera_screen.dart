import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile5/models/post.dart';
import 'package:mobile5/screens/detail_screen.dart';
import 'package:mobile5/style/list_tile_style.dart';
import 'package:mobile5/widgets/floating_action_button_camera.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('post')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data!.docs[index];
                      return Container(
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 189, 178, 30),
                              width: 8),
                        ),
                        child: ListTile(
                          //contentPadding: const EdgeInsets.all(5.0),
                          tileColor: const Color.fromARGB(255, 227, 198, 221),
                          trailing: Text(
                            post['waste'].toString(),
                            style: listTileTextStyle(),
                          ),
                          title: Text(
                            post['date'].toString(),
                            style: listTileTextStyle(),
                          ),
                          onTap: (() {
                            Post entry = Post(
                                date: post['date'],
                                url: post['url'],
                                waste: post['waste'],
                                location: post['location']);
                            buildItem(entry);
                          }),
                        ),
                      );
                    },
                  ),
                ),
                FabForCamera(),
              ],
            );
          } else {
            return Column(
              children: [
                const Center(
                    heightFactor: 10, child: CircularProgressIndicator()),
                FabForCamera(),
              ],
            );
          }
        });
  }

  void buildItem(Post post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(post: post),
        ));
  }
}
