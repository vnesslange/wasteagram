import 'package:mobile5/models/post.dart';
import 'package:test/test.dart';

void main() {
  test('Test model class Post', () {
    final String date = '2020-03-03';
    final String url = 'FAKE';
    final int waste = 5;
    final String location = "10.212152 10212132";

    var testPost = Post(date: date, url: url, location: location, waste: waste);

    expect(testPost.date, date);
    expect(testPost.url, url);
    expect(testPost.location, location);
    expect(testPost.waste, waste);
  });
}
