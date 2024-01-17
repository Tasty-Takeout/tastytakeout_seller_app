import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/view_models/ListFoodMenuViewModel.dart';
import '../../models/DTO/FoodModel.dart';
import '../../helper/format_helper.dart' as formatHelper;
import '../screens/menu_update_food_screen.dart';

class MenuFoodItemWidget extends StatelessWidget {
  late int foodIndex;
  final bool isClickable;
  late ListFoodMenuViewModel _listFoodMenuViewModel =
      Get.find<ListFoodMenuViewModel>();

  MenuFoodItemWidget({
    required this.foodIndex,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = _listFoodMenuViewModel
            .foodList[foodIndex].imageUrls.isNotEmpty
        ? _listFoodMenuViewModel.foodList[foodIndex].imageUrls[0]
        : 'https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg';

    return Obx(() => Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.fastfood),
                      SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  _listFoodMenuViewModel
                                      .foodList[foodIndex].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formatHelper.formatMoney(
                                      _listFoodMenuViewModel
                                          .foodList[foodIndex].price),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(width: 20),
                            PopupMenuButton(
                              icon: Icon(Icons.more_horiz),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text('Sửa'),
                                  value: 'edit',
                                ),
                                PopupMenuItem(
                                  child: Text('Xóa'),
                                  value: 'delete',
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'delete') {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.confirm,
                                    title: "Xác nhận",
                                    text: "Chắc chắn muốn xoá món ăn này?",
                                    confirmBtnColor: Colors.redAccent,
                                    cancelBtnText: "Hủy",
                                    confirmBtnText: "Xác nhận",
                                    onConfirmBtnTap: () {
                                      _listFoodMenuViewModel
                                          .deleteFood(foodIndex);

                                      //Get.back();
                                    },
                                    onCancelBtnTap: () {
                                      Get.back();
                                    },
                                  );
                                } else if (value == 'edit') {
                                  _listFoodMenuViewModel
                                          .singleFoodUpdated.value =
                                      _listFoodMenuViewModel
                                          .foodList[foodIndex];
                                  Get.to(() => MenuFoodPage());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

/*
* return Obx(() => Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.fastfood),
                    SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_listFoodMenuViewModel.foodList[foodIndex].name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${formatHelper.formatMoney(_listFoodMenuViewModel.foodList[foodIndex].price)}',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    // 3 dots
                    PopupMenuButton(
                      icon: Icon(Icons.more_horiz),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Xóa'),
                          value: 'delete',
                        ),
                        PopupMenuItem(
                          child: Text('Sửa'),
                          value: 'edit',
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'delete') {
                          _listFoodMenuViewModel.deleteFood(foodIndex);
                        } else if (value == 'edit') {
                          Get.toNamed('/edit_food',
                              arguments:
                                  _listFoodMenuViewModel.foodList[foodIndex]);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));*/
