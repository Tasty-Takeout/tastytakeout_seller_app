import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/widgets/foods_list.dart';
import '../../helper/format_helper.dart' as formatHelper;
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import '../../models/DTO/OrderModel.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../widgets/order_info.dart';
import '../widgets/order_item.dart';

class ReceiveOrderPage extends StatelessWidget {
  int index;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  ReceiveOrderPage({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết đơn hàng'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OrderInfoWidget(index: index),
            Expanded(child: Container()),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${_listOrdersViewModel.filteredOrderList[index].getQuantity()} Món',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  '${formatHelper.formatSeperateMoney(_listOrdersViewModel.filteredOrderList[index].calculatePrice())}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
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
                      onPressed: () {
                        // popup dialog
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.confirm,
                          title: "Xác nhận",
                          text: "Chắc chắn muốn từ chối đơn hàng này?",
                          confirmBtnColor: Colors.redAccent,
                          cancelBtnText: "Hủy",
                          confirmBtnText: "Xác nhận",
                          onConfirmBtnTap: () {
                            // call api to reject order
                            _listOrdersViewModel.filteredOrderList[index]
                                .status = data.REJECTED;
                            var result =
                                _listOrdersViewModel.syncOrderInfo(index);
                          },
                          onCancelBtnTap: () {
                            Get.back();
                            Get.back();
                          },
                        );
                      },
                      child: Text(
                        'Từ chối',
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
                      onPressed: () async {
                        _listOrdersViewModel.filteredOrderList[index].status =
                            data.PREPARE;
                        var result =
                            await _listOrdersViewModel.syncOrderInfo(index);
                        // call api here
                        Get.back();
                      },
                      child: Text(
                        'Nhận đơn',
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
