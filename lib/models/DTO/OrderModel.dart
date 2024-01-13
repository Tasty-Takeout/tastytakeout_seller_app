import 'dart:convert';

import '/models/DTO/FoodModel.dart';
import '/data_sources/hardcode.dart' as data;

class OrderModel {
  late final int orderId;
  late final List<FoodModel> foods;
  late final int buyerId;
  late final String buyerName;
  late final String address;
  late final String phoneNumber;
  late String status; // REJECTED, PENDING, PREPARE, DELIVERING , COMPLETED
  late int price;
  late final int storeId;
  late final String storeName;
  late final int voucherId;
  late final String createdAt;
  late final String paymentMethod;

  OrderModel({
    this.orderId = -1,
    this.foods = const [],
    this.buyerId = 0,
    this.buyerName = '',
    this.address = '',
    this.phoneNumber = '',
    this.status = data.PENDING,
    this.price = 0,
    this.storeId = 0,
    this.storeName = '',
    this.voucherId = -1,
    this.createdAt = '',
    this.paymentMethod = 'CASH', // CASH, BANKING
  });

  int calculatePrice() {
    int totalPrice = 0;
    for (var food in foods) {
      totalPrice += food.price * food.quantity;
    }
    return totalPrice;
  }

/* order json data of food
      {
      "foods": [
        {
          "quantity": 2147483647,
          "total": 2147483647,
          "food": 0
        }
      ],
      "address": "string",
      "status": "PENDING",
      "total": 2147483647,
      "created_at": "2024-01-05T09:37:27.827Z",
      "payment_method": "CASH",
      "voucher": 0
    }
   */

  int getQuantity() {
    int totalQuantity = 0;
    for (var food in foods) {
      totalQuantity += food.quantity;
    }
    return totalQuantity;
  }

  String toJson() {
    var voucherValue = voucherId == -1 ? null : voucherId;
    return jsonEncode({
      'foods': foods
          .map((food) => {
                'quantity': food.quantity,
                'total': food.price * food.quantity,
                'food': food.id,
              })
          .toList(),
      'address': address,
      'status': status,
      'total': calculatePrice(),
      'created_at': createdAt,
      'payment_method': paymentMethod,
      'voucher': voucherValue,
    });
  }

  Map<String, dynamic> toMapJson() {
    var voucherValue = voucherId == -1 ? null : voucherId;
    return {
      'foods': foods
          .map((food) => {
                'quantity': food.quantity,
                'total': food.price * food.quantity,
                'food': food.id,
              })
          .toList(),
      'address': address,
      'status': status,
      'total': calculatePrice(),
      'created_at': createdAt,
      'payment_method': paymentMethod,
      'voucher': voucherValue,
    };
  }

  Map<String, dynamic> toUpdateStatusJson() {
    return {
      'status': status,
    };
  }

  void getNextStatus() {
    if (status == data.PENDING) {
      status = data.PREPARE;
    } else if (status == data.PREPARE) {
      status = data.DELIVERING;
    } else if (status == data.DELIVERING) {
      status = data.COMPLETED;
    }
  }
}
