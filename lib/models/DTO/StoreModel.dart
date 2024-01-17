import 'FoodModel.dart';

class StoreModel {
  late final int id;
  late final String name;
  late final String imageUrl;
  late final String address;
  late final int likes;
  late final String phoneNumber;

  late final List<FoodModel> foods;

  StoreModel({
    this.id = 0,
    this.name = '',
    this.imageUrl = '',
    this.address = '',
    this.likes = 0,
    this.phoneNumber = '',
    this.foods = const [],
  });
}
