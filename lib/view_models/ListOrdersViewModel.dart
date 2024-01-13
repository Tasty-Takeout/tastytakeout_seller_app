import 'package:get/get.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;

import '../data_sources/order_source.dart';

class ListOrdersViewModel extends GetxController {
  var orderList = <OrderModel>[].obs;
  var filteredOrderList = <OrderModel>[].obs;
  var isLoading = true.obs;
  var needRefresh = true.obs;

  final List<String> OrderStatus = [
    data.PENDING,
    data.PREPARE,
    data.DELIVERING,
    data.COMPLETED
  ];
  List<String> selectedStatus = [data.PENDING];

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchOrders() async {
    //List<OrderModel> orders = data.orders;
    if (orderList.isEmpty) {
      isLoading.value = true;
    }

    if (needRefresh.value) {
      orderList.value = await OrdersSource().fetchOrders();
      needRefresh.value = false;
    }
    filterOrdersByStatus();
    isLoading.value = false;
  }

  void filterOrdersByStatus() {
    filteredOrderList.value =
        orderList.where((order) => order.status == selectedStatus[0]).toList();
  }

  Future<void> fetchOrderById(int index) async {
    OrderModel _fullInfoOrder =
        await OrdersSource().fetchSingleOrder(filteredOrderList[index].orderId);

    if (_fullInfoOrder.orderId != -1) {
      filteredOrderList[index] = _fullInfoOrder;
    }
  }

  Future<bool> syncOrderInfo(int index) async {
    needRefresh.value = true;
    var result =
        await OrdersSource().updateOrderStatus(filteredOrderList[index]);
    return result;
  }
}
