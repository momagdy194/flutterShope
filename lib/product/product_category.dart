import 'package:mygeneralshope/exception/excption.dart';

class ProductCategory {
  int category_id;
  String category_name, image_direction, image_url;

  ProductCategory(this.category_id, this.category_name, this.image_direction,
      this.image_url);

  ProductCategory.fromjason(Map<String, dynamic> jsonObject) {
    assert(jsonObject['category_id'] != null, 'category_id is null');
    if (jsonObject['category_id'] == null) {
      throw PropertyIsRequired("category_id ");
    }

    assert(jsonObject['category_name'] != null, 'category_name is null');
    if (jsonObject['category_name'] == null) {
      throw PropertyIsRequired("category_name ");
    }

    assert(jsonObject['image_direction'] != null, 'image_direction is null');
    if (jsonObject['image_direction'] == null) {
      throw PropertyIsRequired("image_direction ");
    }

    assert(jsonObject['image_url'] != null, 'image_url is null');
    if (jsonObject['image_url'] == null) {
      throw PropertyIsRequired("image_url ");
    }

    this.category_id = jsonObject['category_id'];
    this.category_name = jsonObject['category_name'];
    this.image_direction = jsonObject['image_direction'];
    this.image_url = jsonObject['image_url'];
  }
}
