import 'package:intl/intl.dart';

class Post {
  final String date;
  final String url;
  final int waste;
  final String location;

  Post(
      {required this.date,
      required this.url,
      required this.waste,
      required this.location});

  String getDate() {
    return date;
  }

  String getURL() {
    return url;
  }

  String getWaste() {
    return waste.toString();
  }

  String getLocation() {
    return location;
  }
}
