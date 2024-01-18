import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/notification_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function() onSearchPressed = () {
    //Get.to(SearchScreen());
  };
  final Function() onNotificationPressed = () {
    Get.to(NotificationScreen());
  };
  final Function() onUserPressed = () {
    if (Get.currentRoute != '/UserInfoPage') {
      //Get.to(UserInfoPage());
    } else
      Get.back();
  };

  CustomAppBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: onSearchPressed,
                ),
              ],
            ),
            Text(
              title,
              style: TextStyle(fontSize: 22),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: onNotificationPressed,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: onUserPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
