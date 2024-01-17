import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/helper/format_helper.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
//import 'package:tastytakeout_user_app/data_sources/user_source.dart';
import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';
import 'package:tastytakeout_user_app/view_models/ListFoodMenuViewModel.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text_box.dart';

class MenuFoodPage extends StatefulWidget {
  @override
  _MenuFoodPageState createState() => _MenuFoodPageState();
}

class _MenuFoodPageState extends State<MenuFoodPage> {
  final _foodController = Get.put(ListFoodMenuViewModel());
  late ImagePicker _imagePicker;
  late XFile _pickedFile;
  late bool _isPicked = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _pickedFile = XFile('');
    _isPicked = false;
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _pickedFile = pickedFile;
          _isPicked = true;
        });
        print("Đường dẫn ảnh: ${_pickedFile.path}");
      }
    } catch (e) {
      print("Lỗi khi chọn ảnh: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin món ăn'),
      ),
      body: Obx(
        () {
          if (_foodController.isLoading.value == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _nameController.text = _foodController.singleFoodUpdated.value.name;
            _priceController.text = formatSeperateMoney(
                _foodController.singleFoodUpdated.value.price);
            _descriptionController.text =
                _foodController.singleFoodUpdated.value.description;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: _isPicked == true
                              ? DecorationImage(
                                  image: FileImage(File(_pickedFile.path)),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: NetworkImage(_foodController
                                      .singleFoodUpdated.value.imageUrls[0]),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: _pickImage,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Tên món",
                        prefixIcon: Icon(Icons.fastfood),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (value) {
                        // Format the input as currency
                        final numericValue =
                            int.tryParse(value.replaceAll(',', ''));
                        if (numericValue != null) {
                          final formattedValue =
                              formatSeperateMoney(numericValue);
                          _priceController.value =
                              _priceController.value.copyWith(
                            text: formattedValue,
                            selection: TextSelection.collapsed(
                                offset: formattedValue.length),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Giá",
                        prefixIcon: Icon(Icons.attach_money_sharp),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: "Mô tả",
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(() {
                    if (_foodController.singleFoodUpdated.value.id == -1) {
                      return ElevatedButton(
                        onPressed: () {
                          _foodController.addFood(FoodModel(
                            name: _nameController.text,
                            storeId: _foodController.foodList.value[0].storeId,
                            price: formatRemoveSeperateMoney(
                                _priceController.text),
                            description: _descriptionController.text,
                            imageUrls: [_pickedFile.path],
                            createdAt: DateTime.now().toString(),
                          ));
                          // call api here

                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 12),
                          child: Text(
                            "Thêm món",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          _foodController.updateFood(FoodModel(
                            id: _foodController.singleFoodUpdated.value.id,
                            name: _nameController.text,
                            storeId: _foodController.foodList.value[0].storeId,
                            price: formatRemoveSeperateMoney(
                                _priceController.text),
                            description: _descriptionController.text,
                            imageUrls: [_pickedFile.path],
                            createdAt: DateTime.now().toString(),
                          ));
                          // call api here

                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 12),
                          child: Text(
                            "Cập nhật",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      );
                    }
                  })
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
