import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/products_model.dart';
import '../views/utils/constants.dart';

class FetchProductsController extends GetxController {
  var isLoading = false.obs;
  List<ProductsModel> productsModel = [];
  Rx<List<ProductsModel>> products = Rx<List<ProductsModel>>([]);
  Rx<List<String>> categories = Rx<List<String>>([]);

  /// data from api are sorted here according
  /// to categories
  sortProduct(int index, String title) {
    products.value = [];
    List<ProductsModel> temp = productsModel
        .where((element) =>
            element.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
    if (index > 0) {
      for (var product in temp) {
        bool isSameCategory =
            categories.value[index].compareTo(product.category) == 0;
        if (isSameCategory) {
          products.value.add(product);
        }
      }
    } else {
      products.value = temp;
    }
  }

  /// http get method for retrieving all the data from RESTApi
  Future<void> fetchData() async {
    var myHeaders = {
      'Content-Type': 'application/json',
    };

    Uri apiUrl = Uri.parse(APIROOT);

    return http.get(apiUrl, headers: myHeaders).then((value) {
      /// if the statuscode is 200 then I store the products from api
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        categories.value.add("all");
        for (var tempData in jsonData) {
          ProductsModel product = ProductsModel.fromJson(tempData);
          categories.value.add(product.category);
          productsModel.add(product);
        }

        isLoading(true);

        /// to create the list with distinct value
        categories.value = categories.value.toSet().toList();
        sortProduct(0, "");
      } else {
        /// if any error due to statuscode
        Get.snackbar("Error StatusCode ${value.statusCode}",
            "Facing Difficulties Retrieving Data");
      }
    }).catchError((onError) {
      Get.snackbar("Wrong", "Something went wrong. ${onError.toString()}");
    });
  }
}
