import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/store_screen.dart';
import '/views/screens/mainhome_screen.dart';
import '/views/screens/orders_screen.dart';
import '/views/screens/chat_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(GetMaterialApp(
    title: 'Tasty Takeout',
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    defaultTransition: Transition.fadeIn,
    getPages: [
      GetPage(
        name: '/home',
        page: () => HomePage(),
        binding: HomeBinding(),
      ),
    ],
  ));
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var currentIndex = 0.obs;

  final pages = <String>[
    '/main_home',
    '/store',
    '/orders',
    '/chat',
  ];

  void changePage(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/main_home') {
      return GetPageRoute(
        settings: settings,
        page: () => MainHomePage(),
        binding: MainHomeBinding(),
      );
    }

    if (settings.name == '/store') {
      return GetPageRoute(
        settings: settings,
        page: () => StorePage(),
        binding: StoreBinding(),
      );
    }

    if (settings.name == '/orders') {
      return GetPageRoute(
        settings: settings,
        page: () => OrdersPage(),
        binding: OrdersBinding(),
      );
    }

    if (settings.name == '/chat') {
      return GetPageRoute(
        settings: settings,
        page: () => ChatPage(),
        binding: ChatBinding(),
      );
    }

    return null;
  }
}

PopularPage() {}

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: '/main_home',
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                label: 'Store',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.delivery_dining_sharp),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mark_chat_unread),
                label: 'Chat',
              ),
            ],
            currentIndex: controller.currentIndex.value,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: controller.changePage),
      ),
    );
  }
}
