import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/helper/date_helper.dart';

class MainHomeScreenViewModel extends GetxController {
  var isLoading = true.obs;
  var thisMonth = DateTime.now().month;
  var thisMonthStatic = Rx<List<int>>(List.filled(DateHelper.getDaysInMonth(DateTime.now()) + 1, 0));
  final baseUrl = 'http://$serverIp/stores/1/get_revenue/';
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODg2MDAyNDYwLCJpYXQiOjE3MDQ1NjI0NjAsImp0aSI6ImNmNzVkMmQ0MWY2NDQzZjg4M2M1NmJkNzU2NWI5NDk2IiwidXNlcl9pZCI6MTEsInJvbGUiOiJTRUxMRVIiLCJzdG9yZV9pZCI6Mn0.ewntBGHVz4Grgs5tb3JQqiZMkPwcrwNDHeavAgBLDSo';
  var data = Rx<List<BarChartGroupData>>([]);
  var rng = Random();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await post(
        Uri.parse(baseUrl),
        body: jsonEncode({
          "frequency": "day",
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );

      if (response.statusCode == 200) {
        print('fetchData success');
        print(response.body);
        List<dynamic> jsonBody = jsonDecode(utf8.decode(response.bodyBytes))["revenue_data"];
        for (var item in jsonBody) {
          thisMonthStatic.value[DateTime.parse(item['truncate_date']).day] = item['total_revenue'];
        }
        for (int i = 1; i <= thisMonthStatic.value.length; i++) {
          data.value.add(
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: 10,
                  color: Colors.blue,
                ),
              ],
              showingTooltipIndicators: [0],
            ),
          );
        }
        print(thisMonthStatic.value.length);
        print(data.value);
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error in fetching data ' + e.toString());
    } finally {
      isLoading(false);
    }
  }
}