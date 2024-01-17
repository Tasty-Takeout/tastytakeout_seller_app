import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:tastytakeout_user_app/globals.dart';

class FoodSource {
  // final String apiUrl = 'http://localhost:8000/foods/';

  // final baseUrl = Uri.http('10.0.2.2:8080', '/foods/');

  final baseUrl = Uri.http(serverIp, '/foods/');

  // Future<void> fetchData() async {
  //   try {
  //     final response = await http.get(
  //       baseUrl
  //       // headers: {
  //       //   'accept': 'application/json',
  //       //   'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
  //       // },
  //     );

  //     if (response.statusCode == 200) {
  //       // Successful GET request
  //       print('Response: ${response.body}');

  //       var jsonString = response.body;

  //       // Parse the JSON string
  //       List<dynamic> jsonData = json.decode(jsonString);

  //       // Extract information
  //       if (jsonData.isNotEmpty) {
  //         Map<String, dynamic> foodItem = jsonData[0];

  //         int id = foodItem['id'];
  //         String categoryName = foodItem['category']['name'];
  //         String storeName = foodItem['store']['name'];
  //         double rating = foodItem['rating'];
  //         // Add more fields as needed

  //         // Print extracted information
  //         print('ID: $id');
  //         print('Category Name: $categoryName');
  //         print('Store Name: $storeName');
  //         print('Rating: $rating');
  //         // Print more fields as needed
  //       }

  //     } else {
  //       // Error handling for unsuccessful requests
  //       print('Request failed with status: ${response.statusCode}');
  //     }

  //   } catch (e) {
  //     // Exception handling
  //     print('Exception during request: $e');
  //   }
  // }

  Future<Iterable> getPopularFoodImages(double rating) async {
    try {
      final uri = Uri.parse('$baseUrl?order=&rating__gt=$rating');
      // final response = await http.get(uri);
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          // 'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = response.body;
        List<dynamic> jsonData = json.decode(jsonString);

        // Extract image URLs
        Iterable imageUrls = jsonData
            .map((foodItem) => foodItem['image_urls'] != null
                ? foodItem['image_urls'][0]
                : null)
            .where((imageUrl) => imageUrl != null);

        return imageUrls;
      } else {
        // Error handling for unsuccessful requests
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Exception handling
      print('Exception during request: $e');
      return [];
    }
  }

  Future<Iterable> getFoodWithRating(double rating) async {
    try {
      final uri = Uri.parse('$baseUrl?order=&rating__gt=$rating');
      // final response = await http.get(uri);
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          // 'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = utf8.decode(response.bodyBytes);
        List<dynamic> jsonData = json.decode(jsonString);

        Iterable foods =
            jsonData.map((foodItem) => FoodModel.fromJson(foodItem))
            // .where((food) => food)
            ;

        return foods;
      } else {
        // Error handling for unsuccessful requests
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Exception handling
      print('Exception during request: $e');
      return [];
    }
  }

  Future<Iterable> getFavoriteFood() async {
    try {
      final uri = Uri.parse('$baseUrl?is_liked=true');
      // final response = await http.get(uri);
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          // 'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = utf8.decode(response.bodyBytes);
        List<dynamic> jsonData = json.decode(jsonString);

        Iterable foods =
            jsonData.map((foodItem) => FoodModel.fromJson(foodItem))
            // .where((food) => food)
            ;

        return foods;
      } else {
        // Error handling for unsuccessful requests
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Exception handling
      print('Exception during request: $e');
      return [];
    }
  }

  Future<Iterable> getFoodWithName(String queryString) async {
    try {
      final uri = Uri.parse('$baseUrl?name=$queryString');
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          // 'X-CSRFToken': 'n5Lm8twiNK1239FTN1RwuCGcVFzHIdHW6iVxVnFeMYk5TWdVVhR7nRKyl66L2Q47',
        },
      );

      if (response.statusCode == 200) {
        // var jsonString = response.body;
        var jsonString = utf8.decode(response.bodyBytes);
        List<dynamic> jsonData = json.decode(jsonString);

        Iterable foods =
            jsonData.map((foodItem) => FoodModel.fromJson(foodItem))
            // .where((food) => food)
            ;

        return foods;
      } else {
        // Error handling for unsuccessful requests
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Exception handling
      print('Exception during request fetch FoodData: $e');
      return [];
    }
  }

  /* example json
          {
              "id": 1,
              "category": {
                "id": 1,
                "name": "Giải khát"
              },
              "store": {
                "id": 1,
                "owner": 10,
                "name": "string",
                "image_url": "asdfasdfasdfasdfasd21312",
                "address": "asdfasdfasdfasdf"
              },
              "comments": [
                {
                  "content": "asdfasdf",
                  "rating": 2
                }
              ],
              "image_urls": [
                "https://down-vn.img.susercontent.com/file/5aa046244b29831d9cae7f5608de9832",
                "https://down-vn.img.susercontent.com/file/954effb78327af5c83442e90de135795",
                "https://down-vn.img.susercontent.com/file/0ae2a8416fdfa7fae1b396817303df8f"
              ],
              "name": "[DATE MỚI 100%] Cơm Tự Sôi Thơm Ngon ăn liền ( 4 Vị ) mới nhất hiện nay",
              "description": "Cơm Tự Sôi Thơm Ngon ăn liền 4 Vị mới hiện nay\ntặng kèm quý khách gà cay tứ xuyên để ăn kèm cơm tự xôi nhé.\nquý khách mua lẻ thêm chỉ phải bỏ ra thêm 2500 đồng thôi ạ.\nlưu ý : ăn kèm với cơm tự xôi ngon lắm nhé hihi\nThông tin sản phẩm\nTên sản phẩm: Cơm tự sôi ăn liền của nhà @Anvatnaoban\nXuất xứ: Trùng Khánh\nKhối lượng: 260g \nNSX: in trên bao bì\nHSD: 9 tháng kể từ ngày sản xuất\nBảo quản: nơi khô ráo, thoáng mát\nHDSD: xem trên bao bì sản phẩm\n-Hương vị thịt bò khoai tây 260g: gói rau 50g, gói gạo 100g, gói nước 100g hộp \n-Thịt kho nấm hương 260g: gói rau 50g, gói gạo 100g, gói nước 100g \n-Cá thơm thịt băm 260g: gói rau 50g, gói gạo 100g, gói nước 100g hộp \n-Cà ri gà hương vị 260g: gói rau 50g, gói gạo 100g, gói nước 100g hộp 48 \nLưu ý:\n1. Không đặt nồi lên kính khi nấu\n2. Trong quá trình nấu, không chạm vào nồi để tránh bị bỏng\n3. Không chặn lỗ thông hơi trong quá trình nấu\nhàng nhà mình date luôn mới các tình yêu nhé\nNGÀY IN TRÊN BAO BÌ LÀ NGÀY SẢN XUẤT Ạ\nHạn sử dụng 270 ngày kể từ ngày sản xuất\n\nCách SD: Bóc bao bì và thưởng thức. Có thể ăn với cơm,chế biến các món ăn. - Cách bảo quản: Bảo quản nơi râm mát, tránh ánh nắng măt trời.\n Shop CAM KẾT \nVề sản phẩm: Shop cam kết cả về CHẤT LIỆU cũng như HÌNH DÁNG ( đúng với những gì được nêu bật trong phần mô tả sản phẩm). \nVề giá cả : Shop nhập với số lượng nhiều và trực tiếp nên chi phí sẽ là RẺ ƞhất nhé. \nVề dịch vụ: Shop sẽ cố gắng trả lời hết những thắc mắc xoay quanh sản phẩm nhé. \nThời gian chuẩn bị hàng: Hàng có sẵn, thời gian chuẩn bị tối ưu giao hàng nhanh ạ\nKHÁCH HÀNG LÀ NGƯỜI THÂN\n--------------------------------------------\n#chanvitcay #chan_vit_cay #chân _vịt_cay # Chân_vịt #canhvitcay #canhvitcaygiare #chan_canh_vit #cánh_vịt_cay #vuanuongtrυnghoa\n--------------------------------------------\nchân vịt cay ; cánh vịt cay ; chân vịt ; chân vịt Giá Rẻ ; Chân vịt Rẻ ; chân vịt cay trυng quốc ;chân vịt cay dechang ; chân vịt cay phúc kiến ; chân vịt ngon; chân vịt đóng hộp ; chân vịt ăn vặt ; chân vịt ngon rẻ ; chân vịt rẻ ;chân vịt đỏ ;chân vịt xanh ;chân vịt \n------------------------------------------- \n#chân_vịt_cay #cánh_vịt_cay #chân _vịt#chân_vịt_trυng _quốc#chân_vịt #chanvit#chânvit #chân_vịt_cay\n#chanvit# \n#chanvitcay# \n#doanvat# \n#trυngquoc#",
              "price": 123000,
              "quantity": 243,
              "created_at": "2023-12-26T04:31:41.470000Z",
              "rating": 4
            }
           */

  Future<FoodModel> getSimpleFoodDataById(int foodId) async {
    try {
      final uri = Uri.parse('$baseUrl$foodId/');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var jsonString = utf8.decode(response.bodyBytes);
        Map<String, dynamic> foodItem = json.decode(jsonString);

        int id = foodItem['id'];
        String foodName = foodItem['name'];
        int storeId = foodItem['store']['id'];
        String storeName = foodItem['store']['name'];
        int price = foodItem['price'];
        String basicImage = foodItem['image_urls'][0];

        var _food = FoodModel(
          id: id,
          name: foodName,
          storeId: storeId,
          storeName: storeName,
          price: price,
          imageUrls: [basicImage],
        );

        return _food;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during request Single Food: $e');
    }
    return FoodModel.defaultModel();
  }
}
