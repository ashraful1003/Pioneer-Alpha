import 'package:get/get.dart';

import 'fetch_products_controller.dart';

class InitController implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(FetchProductsController());
  }
}