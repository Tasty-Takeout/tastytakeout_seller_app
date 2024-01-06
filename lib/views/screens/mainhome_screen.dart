import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';

import '../widgets/custom_drawer.dart';

class MainHomeController extends GetxController {
  final title = 'MainHome'.obs;
}

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomeController());
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
  }

  @override
  Widget build(BuildContext context) {
    // final mainHomeViewModel = Provider.of<MainHomeViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Trang chủ",
      ),
      drawer: CustomDrawer(),
      body: SizedBox(),
    );
  }
}
