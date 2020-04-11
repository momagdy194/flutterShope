import 'dart:async';

import 'package:mygeneralshope/api/api_utill.dart';
import 'package:mygeneralshope/api/helper_api.dart';
import 'package:mygeneralshope/contract/contract.dart';
import 'package:mygeneralshope/exception/excption.dart';
import 'package:mygeneralshope/product/product_category.dart';
import 'package:http/http.dart' as http;

class CategoryStream implements Disposable {
  List<ProductCategory> categories;

  StreamController<List<ProductCategory>> _categoryStream = StreamController<
      List<ProductCategory>>.broadcast();
HelperApi helperApi=HelperApi();
  Stream<List<ProductCategory>> get categoryStream => _categoryStream.stream;

  StreamSink<List<ProductCategory>> get categorySink => _categoryStream.sink;


  CategoryStream() {
    categories = [];
    _categoryStream.add(categories);
    _categoryStream.stream.listen(_fetchCategories);
  }

  Future<void>_fetchCategories(List<ProductCategory>categories)async{
    this.categories =await helperApi.fetchCategories();
    _categoryStream.add(categories);

  }

  @override
  void dispose() {
_categoryStream.close();
  }
}
