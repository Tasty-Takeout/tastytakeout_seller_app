import '/models/DTO/FoodModel.dart';
import '/data_sources/hardcode.dart' as data;

class OrderModel {
  late final String orderId;
  late final String storeId;
  late final String storeName;
  late final List<FoodModel> foods;
  late int price;
  late String status; // Prepare, Pending, Completed

  OrderModel({
    this.orderId = '',
    this.storeId = '',
    this.storeName = '',
    this.foods = const [],
    this.price = 0,
    this.status = data.Prepare,
  });

  int calculatePrice() {
    int totalPrice = 0;
    for (var food in foods) {
      totalPrice += food.price * food.quantity;
    }
    return totalPrice;
  }
}
