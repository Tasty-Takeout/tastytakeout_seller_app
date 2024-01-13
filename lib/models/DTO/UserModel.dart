class UserModel {
  late final String name;
  late final String phone;
  late final List<String> address;
  late final String email;
  late final String password;

  UserModel({
    this.name = '',
    this.phone = '',
    this.address = const [],
    this.email = '',
    this.password = '',
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
  }

  String getAddress() {
    if (address.length == 0) {
      return '';
    }
    return address[0];
  }
}
