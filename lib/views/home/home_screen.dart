import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/fetch_products_controller.dart';
import '../utils/constants.dart';
import 'product_card.dart';
import 'search_box.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  RxInt categoryIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    FetchProductsController fetchProductsController = Get.find();
    fetchProductsController.fetchData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,
        title: const Text('Home'),
        actions: [
          /// this will show your ordered items
          IconButton(
              onPressed: () {
                // Get.to(() => const OrderedProductScreen());
              },
              icon: const Icon(Icons.sort)),
        ],
      ),
      body: Obx(() => fetchProductsController.isLoading.value
          ? Column(
              children: [
                /// implementing search box with every keystrokes
                Obx(() => SearchBox(
                      index: categoryIndex.value,
                    )),

                /// show all the categories
                // Obx(() => Categories(
                //       categories: fetchProductsController.categories.value,
                //       onChanged: (newIndex) {
                //         categoryIndex.value = newIndex;
                //         fetchProductsController.sortProduct(
                //             categoryIndex.value, "");
                //       },
                //     )),

                /// show the products
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 70),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Obx(() => ListView.builder(
                          itemCount:
                              fetchProductsController.products.value.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              itemIndex: index,
                              product:
                                  fetchProductsController.products.value[index],
                            );
                          })),
                    ],
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator())),
    );
  }
}
