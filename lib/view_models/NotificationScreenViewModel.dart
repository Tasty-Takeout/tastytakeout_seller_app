import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../globals.dart';
import '../models/DTO/NotificationModel.dart';

class NotificationScreenViewModel extends GetxController {
  final BASE_URL = 'http://$serverIp/notifications/';
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODg2MDAyNDYwLCJpYXQiOjE3MDQ1NjI0NjAsImp0aSI6ImNmNzVkMmQ0MWY2NDQzZjg4M2M1NmJkNzU2NWI5NDk2IiwidXNlcl9pZCI6MTEsInJvbGUiOiJTRUxMRVIiLCJzdG9yZV9pZCI6Mn0.ewntBGHVz4Grgs5tb3JQqiZMkPwcrwNDHeavAgBLDSo';
  var isLoading = false.obs;
  var notificationList = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      var response = await get(
        Uri.parse(BASE_URL),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        notificationList.value = jsonBody.map((e) => NotificationModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
