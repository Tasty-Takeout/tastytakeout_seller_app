import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/store_source.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;

class ListFoodMenuViewModel extends GetxController {
  var foodList = <FoodModel>[].obs;
  var singleFoodUpdated = FoodModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchFoodMenu() async {
    //List<OrderModel> orders = data.orders;
    if (foodList.isEmpty) {
      isLoading.value = true;
    }

    //orderList.value = await OrdersSource().fetchOrders();
    //foodList.value = data.foods;
    foodList.value = (await StoreSource().fetchStoreInfo()).foods;
    isLoading.value = false;
  }

  void deleteFood(int foodIndex) {
    StoreSource().deleteFood(foodList[foodIndex].id);

    foodList.removeAt(foodIndex);
  }

  void addFood(FoodModel food) {
    foodList.add(food);

    StoreSource().addFood(food);
  }

  void updateFood(FoodModel food) {
    foodList[foodList.indexWhere((element) => element.id == food.id)] = food;

    StoreSource().updateFood(food);
  }
}
