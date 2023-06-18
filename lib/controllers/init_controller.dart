import 'package:get/get.dart';
import 'package:pioneer_alpha/controllers/landing_controller.dart';
import 'package:pioneer_alpha/controllers/shopping_controller.dart';

import 'fetch_products_controller.dart';

class InitController implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(FetchProductsController());
    Get.put(LandingController());
    Get.put(ShoppingController());
  }
}
