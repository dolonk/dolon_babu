import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'model_class.dart';

class ApiIntegration {

  Future<List<CategoryModelClass>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('https://grozziie.zjweiting.com:8033/tht/BackgroundCategories'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((json) => CategoryModelClass.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Map<String, dynamic>>> fetchImages(String categoryName) async {
    final response = await http.get(
      Uri.parse(
          'https://grozziie.zjweiting.com:8033/tht/backgroundImgs/$categoryName'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) {
        return {
          'image': json['image'] != null
              ? 'https://grozziie.zjweiting.com:8033/tht/backgroundImgs/${json['image']}'
              : 'assets/images/default_icon.png',
          'height': json['height'] ?? 0,
          'width': json['width'] ?? 0,
        };
      }).toList();
    } else {
      throw Exception('Failed to load images');
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
