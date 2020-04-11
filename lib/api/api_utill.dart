import 'package:connectivity/connectivity.dart';
import 'package:mygeneralshope/exception/excption.dart';

class ApiUtl {
  static const String MAIN_API_URL = 'http://10.0.2.2:8000/api/';
  static const String AUTH_REGISTER = MAIN_API_URL + 'auth/register';
  static const String AUTH_LOGIN = MAIN_API_URL + 'auth/login';
  static const String PRODUCT = MAIN_API_URL + 'products';

  static String CATEGORY_PRODUCTS(int id,int page){
    return MAIN_API_URL+'categories/'+ id.toString()+'/products?page'+page.toString();
  }

  static const String PRODUCT_ID = MAIN_API_URL + 'products/';

  static const String CATEGORIES = MAIN_API_URL + 'categories/';

  static const String COUNTRIES = MAIN_API_URL + 'countries/';
  static const String TAGS = MAIN_API_URL + 'tags/';
  static const String CART = MAIN_API_URL + 'carts';


  static String STATES(int id) {
    return COUNTRIES + id.toString() + '/states';
  }

  static String CITIES(int id) {
    return COUNTRIES + id.toString() + '/cities';
  }
}





Future<void> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    throw NoInterNetConnection();
  }
}