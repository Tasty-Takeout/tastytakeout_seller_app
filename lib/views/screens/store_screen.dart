import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';

import '../widgets/custom_drawer.dart';

class StoreController extends GetxController {
  final title = 'Store'.obs;
}

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreController());
  }
}

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final StoreViewModel = Provider.of<StoreViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cửa hàng",
      ),
      drawer: CustomDrawer(),
      body: SizedBox(),
    );
  }
}
