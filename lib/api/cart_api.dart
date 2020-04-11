import 'dart:convert';
import 'package:mygeneralshope/card/cart.dart';
import 'package:mygeneralshope/exception/excption.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_utill.dart';
import 'package:http/http.dart' as http;
class CartApi {
  Future<Cart> feachCart() async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    Map<String, String> authHeader = {
      'Accept': 'application/json',
      'Authorizathion': 'Bearer' + apiToken
    };

    String cartApi = ApiUtl.CART;
    http.Response response = await http.get(cartApi, headers: authHeader);

    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        return Cart.fromJason(body);
        break;
      default:
        throw ResourceNotFound('cart');
    }
  }

  Future<bool> addProductToCard(int productID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    String CartApi = ApiUtl.CART;
    print(apiToken);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorizathion': 'Bearer' + apiToken
    };
    await checkInternet();
    Map<String, dynamic> body = {
      'product_id': productID.toString(),
      'qty': 1.toString()
    };

    http.Response response =
        await http.post(CartApi, headers: headers, body: body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
        break;
      default:
        throw ResourceNotFound('cart');
        break;
    }
  }
}
