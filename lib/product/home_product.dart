import 'dart:async';
import '../contract/contract.dart';
import 'package:mygeneralshope/product/product.dart';
import '../api/product_api.dart';

class HomeProductBlock implements Disposable {
  List<Product> products;
  ProductsAPI productsAPI;
  final StreamController<List<Product>> _productController =
      StreamController<List<Product>>.broadcast();
  final StreamController<int> _categoryController =
      StreamController<int>.broadcast();

  Stream<List<Product>> get productStream => _productController.stream;

  StreamSink<int> get fetchProduct => _categoryController.sink;

  Stream<int> get category => _categoryController.stream;
  int categoryID;

  HomeProductBlock() {
    this.products = [];
    productsAPI = ProductsAPI();

    _productController.add(this.products);
    _categoryController.add(this.categoryID);
    _categoryController.stream.listen(_fetchCategoryFromApi);
  }

  Future<void> _fetchCategoryFromApi(int category) async {
    this.products = await productsAPI.fetchProductByCategory(category, 1);
    _productController.add(this.products);
    print(this.products[0].product_id);
  }

  @override
  void dispose() {
    _productController.close();
    _categoryController.close();
  }
}
