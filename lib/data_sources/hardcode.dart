import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';

import '/models/DTO/FoodModel.dart';
import '/models/DTO/OrderModel.dart';

final String accessKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODg2OTQ2Mzg4LCJpYXQiOjE3MDU1MDYzODgsImp0aSI6ImQwZjM5NmJiOWJhMjQwYTliM2U5MDQzYTBhZDEwYWUwIiwidXNlcl9pZCI6MTEsInJvbGUiOiJTRUxMRVIiLCJzdG9yZV9pZCI6MX0.lrExYQDuWB1qoRaQYAvDDcKZjKhQU06u9hLBjYgA3NU';

/// Const variable
const String REJECTED = 'REJECTED';
const String PENDING = 'PENDING';
const String PREPARE = 'PREPARE';
const String DELIVERING = 'DELIVERING';
const String COMPLETED = 'COMPLETED';

var mapStatus = {
  PENDING: 'Đơn Mới',
  PREPARE: 'Đã nhận',
  DELIVERING: 'Đang giao',
  COMPLETED: 'Lịch sử'
};

var paymentMap = {'CASH': 'Tiền mặt', 'BANKING': 'Chuyển khoản'};

final UserModel userModel = UserModel(
    name: 'Nguyễn Văn A', address: '227 Nguyễn Văn Cừ', email: 'nva@gmail.com');

final String imageUrl =
    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Next_Arrow.svg/1200px-Next_Arrow.svg.png';

final List<OrderModel> orders = [
  OrderModel(
      orderId: 1,
      storeId: 1,
      storeName: "Store 1",
      status: COMPLETED,
      buyerName: 'Nguyễn Văn A',
      phoneNumber: '0123456789',
      address: '227 Nguyễn Văn Cừ',
      foods: foods.sublist(0, 1)),
  OrderModel(
      orderId: 2,
      storeId: 2,
      storeName: "Store 2",
      status: PENDING,
      buyerName: 'Nguyễn Văn B',
      phoneNumber: '0123456789',
      address: '125 Trần Hưng Đạo',
      foods: foods.sublist(0, 4)),
  OrderModel(
      orderId: 3,
      storeId: 3,
      storeName: "Store 3",
      status: PREPARE,
      buyerName: 'Nguyễn Văn C',
      phoneNumber: '0123456789',
      address: '227 Võ Văn Tần',
      foods: foods.sublist(2, 3)),
  OrderModel(
      orderId: 4,
      storeId: 4,
      storeName: "Store 4",
      status: PREPARE,
      buyerName: 'Nguyễn Văn D',
      phoneNumber: '0123456789',
      address: '01 Nguyễn Văn Linh',
      foods: foods.sublist(3, 4))
];

final List<OrderModel> carts = [
  OrderModel(
      orderId: 1,
      storeId: 1,
      storeName: "Store 11",
      status: COMPLETED,
      foods: foods.sublist(0, 1)),
  OrderModel(
      orderId: 2,
      storeId: 2,
      storeName: "Store 22",
      status: PREPARE,
      foods: foods.sublist(1, 2)),
  OrderModel(
      orderId: 3,
      storeId: 3,
      storeName: "Store 33",
      status: PREPARE,
      foods: foods.sublist(2, 3)),
  OrderModel(
      orderId: 4,
      storeId: 4,
      storeName: "Store 44",
      status: PREPARE,
      foods: foods.sublist(3, 4))
];

List<FoodModel> foods = [
  FoodModel(
    name: 'Chicken Burger store1',
    price: 10000,
    quantity: 1,
    imageUrls: [imageUrl],
  ),
  FoodModel(
    name: 'Chicken Burger store2',
    price: 10000,
    quantity: 1,
    imageUrls: [imageUrl],
  ),
  FoodModel(
    name: 'Chicken Burger store3',
    price: 10000,
    quantity: 1,
    imageUrls: [imageUrl],
  ),
  FoodModel(
    name: 'Chicken Burger store4',
    price: 10000,
    quantity: 1,
    imageUrls: [imageUrl],
  )
];
