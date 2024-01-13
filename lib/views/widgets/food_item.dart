import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/DTO/FoodModel.dart';
import '../../helper/format_helper.dart' as formatHelper;

class FoodItemWidget extends StatelessWidget {
  final FoodModel food;

  FoodItemWidget({
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = food.imageUrls.isNotEmpty
        ? food.imageUrls[0]
        : 'https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg';

    return GestureDetector(
        child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.quantity.toString() + ' x',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            food.name,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          formatHelper
                              .formatSeperateMoney(food.price * food.quantity),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
