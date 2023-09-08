import 'dart:convert';
import 'dart:io';
import 'room_json/rooms.dart';

class ApiClientRoom {
  final client = HttpClient();

  Future<Rooms> getPosts() async {
    final url = Uri.parse('https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd');
    final request = await client.getUrl(url);
    final response = await request.close();
    final string = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join());
    final json = jsonDecode(string) as Map<String, dynamic>;
    final post = Rooms.fromJson(json);
    return post;
  }
}