import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pioneer_alpha/controllers/landing_controller.dart';
import 'package:pioneer_alpha/views/cart/cart_screen.dart';
import 'package:pioneer_alpha/views/home/home_screen.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  final screens = [HomeScreen(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    LandingController landingController = Get.find();
    return Scaffold(
      body: Obx(() => IndexedStack(
          index: landingController.selectedIndex.value, children: screens)),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              landingController.changeIndex(index);
            },
            currentIndex: landingController.selectedIndex.value,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, size: 30), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart, size: 30), label: 'Cart'),
            ],
          )),
    );
  }
}
