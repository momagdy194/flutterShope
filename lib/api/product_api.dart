import 'dart:convert';

import 'package:mygeneralshope/exception/excption.dart';
import 'package:mygeneralshope/product/product.dart';
import 'package:http/http.dart' as http;
import 'api_utill.dart';

class ProductsAPI {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<List<Product>> fetchProduct(int page) async {
    await checkInternet();

    String url = ApiUtl.PRODUCT + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    List<Product> products = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
//        print(item);
        products.add(
          Product.fromJason(item),
        );
      }
      return products;
    }
    return null;
  }

  Future<List<Product>> fetchProductByCategory(int category, int page) async {
    await checkInternet();

    String url = ApiUtl.CATEGORY_PRODUCTS(category, page);
    http.Response response = await http.get(url, headers: headers);
    List<Product> products = [];

    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
//       print(item);
          products.add(
            Product.fromJason(item),
          );
        }
        return products;
        break;
      case 404:
        throw ResourceNotFound('Products');
        break;

      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break;
    }
  }


  Future<Product> fetchProduct_ID(int Product_id) async {
    String url = ApiUtl.PRODUCT_ID + Product_id.toString();

    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var data = Product.fromJason(body['data']);
      return data;
    }
    return null;
  }
}
