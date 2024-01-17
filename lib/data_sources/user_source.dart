import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart';

class UserSource {
  final baseUrl = Uri.http(serverIp, '/users/');
  final loginUrl = Uri.http(serverIp, '/users/login/');

  /* Example JSON response:
         {
          "id": 10,
          "username": "123",
          "email": "user@example.com",
          "avatar_url": "https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg",
          "name": "Hoàng Thị Hồng",
          "bio": "An Phong, thường được biết đến với nghệ danh Lưu Diệc Phi (tiếng Trung: 刘亦菲; bính âm: Liú Yìfēi; tiếng Anh: Crystal Liu, sinh ngày 25 tháng 8 năm 1987), là một nữ diễn viên kiêm ca sĩ người Mỹ gốc Hoa. Cô đã nhiều lần xuất hiện trong danh sách 100 ngôi sao nổi tiếng nhất Trung Quốc theo Forbes và được vinh danh là một trong Tứ Tiểu Hoa Đán của Trung Quốc vào năm 2009.[1] Cô được biết đến rộng rãi với biệt danh \"Thần tiên tỷ tỷ\" ở Trung Quốc.[2][3]",
          "address": "Trung Quốc",
          "date_of_birth": "2000-12-30T08:55:34.754000Z",
          "gender": "MALE"
        }
          */

  Future<String> getAccessToken() async {
    return data.accessKey;
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

  Future<UserModel> getUserInfo() async {
    try {
      final response = await http.get(
        baseUrl,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = utf8.decode(response.bodyBytes);
        var jsonMap = jsonDecode(jsonString);

        return UserModel.fromJson(jsonMap);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during request User: $e');
    }
    return UserModel();
  }

  Future<http.Response> patchUserInfo(UserModel _userModel) async {
    try {
      final response = await http.patch(
        baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
        body: jsonEncode(_userModel.toMapJson()),
      );
      return response;
    } catch (e) {
      print('Exception during POST request: $e');
      return http.Response('Error during request', 500);
    }
  }
}
