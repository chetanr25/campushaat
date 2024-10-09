import 'dart:convert';
import 'package:campushaat/models/food_items.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String baseUrl =
      'http://chprod-env.eba-psapqnmi.ap-south-1.elasticbeanstalk.com/webapi';

  Future<List<FoodItem>> fetchProducts({
    // required String creatorId,
    required String apiKey,

    // required String categoryId,
    int start = 0,
    int limit = 10,
  }) async {
    final url = '$baseUrl/products/productSearch';
    print(apiKey);
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "creator": {
          "id": "6873",
          "creatorId": '298',
          "APIKey": apiKey,
          "applicationId": "1",
          "createDate": DateTime.now().toIso8601String(),
        },
        "campusId": '7740',
        "productCategory": {
          "selectedFilter": {
            "categoryId": '15',
          }
        },
        "productSection": "0",
        "loadType": 8,
        "limit": limit,
        "start": start,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsList = data['productsList'][0]['products'];
      return productsList.map((json) => FoodItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
