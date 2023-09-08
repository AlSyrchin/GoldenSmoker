import 'dart:convert';
import 'dart:io';
import 'bron__json/bron.dart';

class ApiClientBron {
  final client = HttpClient();

  Future<Bron> getPosts() async {
    final url = Uri.parse('https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8');
    final request = await client.getUrl(url);
    final response = await request.close();
    final string = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join());
    final json = jsonDecode(string) as Map<String, dynamic>;
    final post = Bron.fromJson(json);
    return post;
  }
}