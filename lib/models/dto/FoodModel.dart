class FoodModel {
  late final String name;
  late final int price;
  late int quantity;
  late final String imageUrl;

  FoodModel({
    this.name = '',
    this.price = 0,
    this.quantity = 0,
    this.imageUrl = '',
  });

  void setQuantity(int setQuantity) {
    this.quantity = setQuantity;
  }

  int getQuantity() {
    return quantity;
  }
}
