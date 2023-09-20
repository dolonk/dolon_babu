import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'model_class.dart';


class ApiService {
  final String apiUrl = 'https://grozziie.zjweiting.com:8033/tht/allIcons';

  Future<List<IconModel>> fetchIcons() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<IconModel> icons = [];
        for (var item in jsonData) {
          icons.add(IconModel.fromJson(item));
        }
        return icons;
      } else {
        throw Exception('Failed to load icons');
      }
    } catch (e) {
      throw Exception('Check your internet connection');
    }
  }

  Future<Uint8List> downloadImageAsUint8List(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return Uint8List.fromList(response.bodyBytes);
    } else {
      throw Exception("Failed to download image");
    }
  }

}
