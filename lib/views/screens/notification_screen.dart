import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_models/NotificationScreenViewModel.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final viewModel = Get.put(NotificationScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Thông báo'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (viewModel.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            var items = viewModel.notificationList;
            return ListView.separated(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              separatorBuilder: (context, index) => Container(
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index < items.length)
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff73b5c9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          items[index].body,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                else
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        padding: EdgeInsets.all(5),
                        child: Image.asset(
                            "lib/resources/gif/endOfNotification.gif"),
                      ),
                      Text("Không còn thông báo nào nữa cả")
                    ],
                  );
              },
            );
          }
        },
      ),
    );
  }
}
