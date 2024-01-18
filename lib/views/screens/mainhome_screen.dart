import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/store_source.dart';
import 'package:tastytakeout_user_app/helper/date_helper.dart';
import 'package:tastytakeout_user_app/view_models/MainHomeScreenViewModel.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';

import '../widgets/custom_drawer.dart';

class MainHomeController extends GetxController {}

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomeController());
    Get.lazyPut(() => MainHomeScreenViewModel());
  }
}

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  void initState() {
    super.initState();
    var res = StoreSource().fetchStoreInfo();
    res.then((value) {
      storeName.value = value.name;
      storeId.value = value.id;
      print('build main home' + storeId.value.toString());
    });
  }
  var viewModel = Get.find<MainHomeScreenViewModel>();

  late var storeId = 0.obs;
  var storeName = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Trang chủ",
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  height: 400,
                  width: double.infinity,
                  child: Image.asset(
                    'lib/resources/images/store.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Obx(
                  () => Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                          child: DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Agne',
                              ),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  RotateAnimatedText(
                                    "Welcome " + storeName.value,
                                  ),
                                ],
                                repeatForever: true,
                              ))),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'Tasty Takeout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Doanh thu tháng này',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Xem chi tiết',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.blue,
                    value: 40,
                    title: '40%',
                    radius: 50,
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: 30,
                    title: '30%',
                    radius: 50,
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    value: 30,
                    title: '30%',
                    radius: 50,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
