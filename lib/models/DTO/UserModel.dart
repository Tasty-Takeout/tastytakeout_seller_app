class UserModel {
  late int storeId;
  late String username;
  late String email;
  late String avatar_url;
  late String name;
  late String address;
  late String bio;
  late String date_of_birth;
  late String gender;

  UserModel({
    this.storeId = -1,
    this.username = '',
    this.email = '',
    this.avatar_url = '',
    this.name = '',
    this.address = '',
    this.bio = '',
    this.date_of_birth = '',
    this.gender = '',
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    storeId = json['stores'][0]['id'];
    username = json['username'];
    email = json['email'];
    avatar_url = json['avatar_url'];
    name = json['name'];
    address = json['address'];
    bio = json['bio'];
    date_of_birth = json['date_of_birth'];
    gender = json['gender'];
  }

  String getAddress() {
    return address;
  }

  int getStoreId() {
    return storeId;
  }

  void update(
      {required String name, required String email, required String address}) {
    this.name = name;
    this.email = email;
    this.address = address;
  }

  /*
  {
  "email": "user@example.com",
  "avatar_url": "string",
  "name": "string",
  "bio": "string",
  "address": "string",
  "date_of_birth": "2024-01-06T09:19:43.656Z",
  "gender": "MALE"
}
   */

  Map<String, dynamic> toMapJson() {
    return {
      'email': email,
      'avatar_url': avatar_url,
      'name': name,
      'bio': bio,
      'address': address,
      'date_of_birth': date_of_birth,
      'gender': gender
    };
  }
}
