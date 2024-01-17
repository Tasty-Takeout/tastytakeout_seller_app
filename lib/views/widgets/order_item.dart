import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/order_complete_screen.dart';
import 'package:tastytakeout_user_app/views/screens/order_delivering_screen.dart';
import 'package:tastytakeout_user_app/views/screens/order_prepare_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/food_item.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/helper/format_helper.dart'
    as formatHelper;

import '../../models/DTO/OrderModel.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../screens/order_receive_screen.dart';

class OrderItemWidget extends GetWidget {
  int index;
  final bool isClickable;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  OrderItemWidget({
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
          //Get.to(() => ReceiveOrderPage(index: index));
          _listOrdersViewModel.fetchOrderById(index);
          var status = _listOrdersViewModel.filteredOrderList[index].status;
          if (status == data.PENDING) {
            Get.to(() => ReceiveOrderPage(index: index));
          } else if (status == data.PREPARE) {
            Get.to(() => PrepareOrderPage(index: index));
          } else if (status == data.DELIVERING) {
            Get.to(() => DeliveringOrderPage(index: index));
          } else if (status == data.COMPLETED) {
            Get.to(() => CompletedOrderPage(index: index));
          }
        },
        child: Obx(
          () => Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 8.0),
                      Icon(Icons.person_pin),
                      SizedBox(width: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Người mua: ${_listOrdersViewModel.filteredOrderList[index].buyerName}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              'Địa chỉ: ${_listOrdersViewModel.filteredOrderList[index].address}'),
                          Text(
                              'Điện thoại: ${_listOrdersViewModel.filteredOrderList[index].phoneNumber}'),
                          SizedBox(height: 12.0),
                          Text(
                              'Số món: ${_listOrdersViewModel.filteredOrderList[index].getQuantity()}'),
                          Text(
                              '${data.paymentMap[_listOrdersViewModel.filteredOrderList[index].paymentMethod]}: '
                              '${formatHelper.formatMoney(_listOrdersViewModel.filteredOrderList[index].calculatePrice())}'),
                        ],
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.confirm,
                            title: "Xác nhận",
                            text: "Chắc chắn muốn chuyển tiếp đơn?",
                            confirmBtnColor: Colors.green,
                            cancelBtnText: "Hủy",
                            confirmBtnText: "Xác nhận",
                            onConfirmBtnTap: () {
                              // call api to reject order
                              _listOrdersViewModel.filteredOrderList[index]
                                  .getNextStatus();
                              var result =
                                  _listOrdersViewModel.syncOrderInfo(index);
                            },
                          );
                        },
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Image.asset(
                                      'lib/resources/images/vertify.png')
                                  .image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
