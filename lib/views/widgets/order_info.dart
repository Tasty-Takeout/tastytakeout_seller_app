import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/widgets/foods_list.dart';
import '../../helper/format_helper.dart' as formatHelper;
import '../../models/DTO/OrderModel.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../widgets/order_item.dart';

class OrderInfoWidget extends StatelessWidget {
  late int index;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  OrderInfoWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    print('Order Id: ${_listOrdersViewModel.filteredOrderList[index].orderId}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OrderItemWidget(index: index, isClickable: false),
        SizedBox(height: 20.0),
        FoodsListWidget(index: index, isClickable: false),
      ],
    );
  }
}
