import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:tastytakeout_user_app/view_models/ListFoodMenuViewModel.dart';
import 'package:tastytakeout_user_app/views/screens/menu_update_food_screen.dart';

import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/menu_food_item.dart';

class StoreController extends GetxController {
  final title = 'Store'.obs;
  final ListFoodMenuViewModel listFoodMenuViewModel = Get.find();

  @override
  void onInit() {
    super.onInit();
    listFoodMenuViewModel.fetchFoodMenu();
  }

  @override
  void onReady() {
    super.onReady();
    listFoodMenuViewModel.fetchFoodMenu();
  }
}

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListFoodMenuViewModel());
    Get.lazyPut(() => StoreController());
  }
}

class StorePage extends StatelessWidget {
  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Cửa hàng"),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Obx(
              () {
                if (storeController.listFoodMenuViewModel.isLoading.value) {
                  String notification = 'Đang tải dữ liệu...';
                  return Expanded(
                      child: Center(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/resources/gif/loading.gif',
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        notification,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                      itemCount:
                          storeController.listFoodMenuViewModel.foodList.length,
                      itemBuilder: (context, index) {
                        return MenuFoodItemWidget(foodIndex: index);
                      },
                    ),
                  );
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.green,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sửa thông tin',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        storeController.listFoodMenuViewModel.singleFoodUpdated
                            .value = FoodModel();
                        Get.to(() => MenuFoodPage());
                      },
                      child: Text(
                        'Thêm món',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
