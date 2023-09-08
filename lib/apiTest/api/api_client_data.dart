import 'dart:convert';
import 'dart:io';
import 'data_json/data.dart';

class ApiClientData {
  final client = HttpClient();

  Future<Data> getPosts() async {
    final url = Uri.parse('https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3');
    final request = await client.getUrl(url);
    final response = await request.close();
    final string = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join());
    final json = jsonDecode(string) as Map<String, dynamic>;
    final post = Data.fromJson(json);
    return post;
  }
}