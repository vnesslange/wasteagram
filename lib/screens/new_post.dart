import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:mobile5/style/list_tile_style.dart';

class NewPost extends StatefulWidget {
  NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File? image;
  final picker = ImagePicker();
  LocationData? locationData;
  var locationService = Location();
  final waste = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    waste.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    return image;
  }

  Future retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
  }

  uploadImage() async {
    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: Semantics(
                button: true,
                onLongPressHint: 'takes you back to last screen.',
                child: IconButton(
                    icon: const Icon(Icons.arrow_circle_left),
                    onPressed: (() {
                      Navigator.pop(context);
                    })),
              ),
              title: const Text(
                "New Post",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Bebas Neue",
                  color: Color.fromARGB(255, 222, 141, 193),
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 9, 45, 50),
            ),
            backgroundColor: const Color.fromARGB(255, 213, 248, 251),
            body: FutureBuilder(
                future: getImage(),
                builder: (context, snapshot) {
                  Widget child;
                  if (snapshot.hasData) {
                    child = Column(children: [
                      Container(
                          constraints: const BoxConstraints(maxHeight: 250),
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 189, 178, 30),
                                width: 8),
                          ),
                          child: Semantics(
                              image: true, child: Image.file(image!))),
                      Center(
                          child: Semantics(
                        hint: "number pad to enter wasted items",
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: listTileTextStyle(),
                          autofocus: true,
                          decoration: const InputDecoration(
                              labelText: 'Number of Wasted Items',
                              labelStyle: TextStyle(
                                fontFamily: "YanoneKaffeesatz",
                                fontSize: 25,
                                color: Color.fromARGB(255, 222, 141, 193),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 25, 10, 25)),
                          controller: waste,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter number wasted items';
                            }
                            return null;
                          },
                        ),
                      )),
                      Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Semantics(
                            button: true,
                            onTapHint: 'uploads entered items into the cloud',
                            child: FloatingActionButton(
                                backgroundColor:
                                    const Color.fromARGB(255, 9, 45, 50),
                                splashColor:
                                    const Color.fromARGB(255, 222, 141, 193),
                                onPressed: (() {
                                  uploadData();
                                }),
                                child: const Icon(
                                  Icons.cloud_download_outlined,
                                  color: Color.fromARGB(255, 222, 141, 193),
                                )),
                          ))
                    ]);
                  } else {
                    child = const CircularProgressIndicator();
                  }
                  return Center(child: child);
                })));
  }

  void uploadData() async {
    if (locationData == null) {
      await retrieveLocation();
    }
    final getDate = DateTime.now();
    final date = DateFormat.yMMMMEEEEd().format(getDate);
    final url = await uploadImage();
    final waste2 = int.parse(waste.text);

    final locationString =
        "Latitude: ${locationData!.latitude} Longitiude: ${locationData!.longitude}";
    FirebaseFirestore.instance.collection('post').add({
      'date': date,
      'location': locationString,
      'url': url,
      'waste': waste2,
      'timestamp': getDate
    });
    Navigator.pop(context);
  }
}
