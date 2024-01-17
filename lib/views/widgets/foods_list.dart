import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/widgets/food_item.dart';
import 'package:tastytakeout_user_app/helper/format_helper.dart'
    as formatHelper;

import '../../models/DTO/OrderModel.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../screens/order_receive_screen.dart';

class FoodsListWidget extends GetWidget {
  int index;
  final bool isClickable;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  FoodsListWidget({
    required this.index,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (_listOrdersViewModel.filteredOrderList.isEmpty ||
        index >= _listOrdersViewModel.filteredOrderList.length) {
      return Container();
    }

    return GestureDetector(
        onTap: () {
          if (!isClickable) return;
          Get.to(() => ReceiveOrderPage(index: index));
        },
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                _listOrdersViewModel.filteredOrderList[index].foods.length,
            itemBuilder: (context, foodIndex) {
              return Column(
                children: [
                  SizedBox(height: 12.0),
                  FoodItemWidget(
                      food: _listOrdersViewModel
                          .filteredOrderList[index].foods[foodIndex]),
                  // add line divider
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              );
            },
          ),
        ));
  }
}
