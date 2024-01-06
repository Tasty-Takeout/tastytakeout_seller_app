import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';

import '/models/DTO/FoodModel.dart';
import '/models/DTO/OrderModel.dart';

/// Const variable
const String Prepare = 'Chuẩn bị';
const String Pending = 'Đang giao';
const String Completed = 'Đã giao';

final UserModel userModel = UserModel(
    name: 'Nguyễn Văn A',
    phone: '0123456789',
    address: ['227 Nguyễn Văn Cừ', 'KTX 135B Trần Hưng Đạo'],
    email: 'nva@gmail.com');

final String imageUrl =
    'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg';

final List<OrderModel> orders = [
  OrderModel(
      orderId: "id1",
      storeId: "s1",
      storeName: "Store 1",
      status: Completed,
      foods: foods.sublist(0, 1)),
  OrderModel(
      orderId: "id2",
      storeId: "s2",
      storeName: "Store 2",
      status: Prepare,
      foods: foods.sublist(1, 2)),
  OrderModel(
      orderId: "id2",
      storeId: "s2",
      storeName: "Store 3",
      status: Prepare,
      foods: foods.sublist(2, 3)),
  OrderModel(
      orderId: "id2",
      storeId: "s2",
      storeName: "Store 4",
      status: Prepare,
      foods: foods.sublist(3, 4))
];

final List<OrderModel> carts = [
  OrderModel(
      orderId: "id1",
      storeId: "s1",
      storeName: "Store 11",
      status: Completed,
      foods: foods.sublist(0, 1)),
  OrderModel(
      orderId: "id2",
      storeId: "s2",
      storeName: "Store 22",
      status: Prepare,
      foods: foods.sublist(1, 2)),
  OrderModel(
      orderId: "id2",
      storeId: "s2",
      storeName: "Store 33",
      status: Prepare,
      foods: foods.sublist(2, 3)),
  OrderModel(
      orderId: "id2",
      storeId: "s2",
      storeName: "Store 44",
      status: Prepare,
      foods: foods.sublist(3, 4))
];

List<FoodModel> foods = [
  FoodModel(
    name: 'Chicken Burger store1',
    price: 10000,
    quantity: 1,
    imageUrl: imageUrl,
  ),
  FoodModel(
    name: 'Chicken Burger store2',
    price: 10000,
    quantity: 1,
    imageUrl: imageUrl,
  ),
  FoodModel(
    name: 'Chicken Burger store3',
    price: 10000,
    quantity: 1,
    imageUrl: imageUrl,
  ),
  FoodModel(
    name: 'Chicken Burger store4',
    price: 10000,
    quantity: 1,
    imageUrl: imageUrl,
  )
];
