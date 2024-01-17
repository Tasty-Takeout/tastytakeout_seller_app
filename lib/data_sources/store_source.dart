import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/data_sources/user_source.dart';
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/models/DTO/StoreModel.dart';
import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';

class StoreSource {
  StoreSource._privateConstructor();

  static final StoreSource _instance = StoreSource._privateConstructor();

  factory StoreSource() {
    return _instance;
  }

  /* Example JSON response:
          [
            {
              "id": 0,
              "foods": [
                {
                  "id": 0,
                  "quantity": 2147483647,
                  "total": 2147483647,
                  "food": 0
                }
              ],
              "address": "string",
              "status": "PENDING",
              "total": 2147483647,
              "created_at": "2024-01-04T17:25:49.634Z",
              "payment_method": "CASH",
              "buyer": 0,
              "voucher": 0
            }
          ]
          */

  final storeUrl = Uri.http(serverIp, '/stores/');
  final loginUrl = Uri.http(serverIp, '/users/login/');

  Future<String> getAccessToken() async {
    return data.accessKey;
    print('Getting access token...');
    final responseLogin = await http.post(
      loginUrl,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': '123',
        'password': '1234',
      }),
    );

    String accessToken = jsonDecode(responseLogin.body)['access'];
    print('Access token: $accessToken');
    return accessToken;
  }

  Future<http.Response> postData(
      Uri uri, Map<String, dynamic> requestData) async {
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
        body: jsonEncode(requestData),
      );
      return response;
    } catch (e) {
      print('Exception during POST request: $e');
      return http.Response('Error during request', 500);
    }
  }

  Future<StoreModel> fetchStoreInfo() async {
    try {
      UserModel _user = await UserSource().getUserInfo();
      int storeId = _user.getStoreId();

      late StoreModel _storeModel;

      final response = await http.get(
        Uri.http(serverIp, '/stores/$storeId/'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(jsonString);

        if (jsonData.isNotEmpty) {
          int id = jsonData['id'];
          String name = jsonData['name'];
          String image_url = jsonData['image_url'];
          String address = jsonData['address'];
          int likers_count = jsonData['likers_count'];

          List<dynamic> foodsJson = jsonData['foods'];
          List<FoodModel> foods = [];

          for (var foodJson in foodsJson) {
            int id = foodJson['id'];
            int storeId = foodJson['store'];
            String name = foodJson['name'];
            String image_url = foodJson['image_urls'][0];
            int price = foodJson['price'];
            double rating = foodJson['rating'];
            String description = foodJson['description'];

            foods.add(FoodModel(
              id: id,
              storeId: storeId,
              name: name,
              imageUrls: [image_url],
              price: price,
              description: description,
              rating: rating,
            ));
          }

          _storeModel = StoreModel(
            id: id,
            name: name,
            imageUrl: image_url,
            address: address,
            likes: likers_count,
            foods: foods,
          );

          return _storeModel;
        }
        return StoreModel();
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during request Store: $e');
    }
    return StoreModel();
  }

  Future<void> addFood(FoodModel food) async {
    try {
      final response = await http.post(
        Uri.http(serverIp, '/foods/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
        body: jsonEncode(food.toMapJson()),
      );

      if (response.statusCode == 201) {
        print('Food added successfully');
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception during request Store: $e');
    }
  }

  Future<void> deleteFood(int id) async {
    try {
      final response = await http.delete(
        Uri.http(serverIp, '/foods/$id/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
      );

      if (response.statusCode == 204) {
        print('Food delete successfully');
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception during request Store: $e');
    }
  }

  Future<void> updateFood(FoodModel food) async {
    try {
      final response = await http.patch(
        Uri.http(serverIp, '/foods/${food.id}/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
        body: jsonEncode(food.toMapJson()),
      );

      if (response.statusCode == 201) {
        print('Food delete successfully');
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception during request Store: $e');
    }
  }
}
