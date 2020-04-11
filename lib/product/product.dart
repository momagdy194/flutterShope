import 'package:flutter/widgets.dart';
import 'package:mygeneralshope/exception/excption.dart';
import 'package:mygeneralshope/product/product_category.dart';
import 'package:mygeneralshope/product/product_unit.dart';
import 'package:mygeneralshope/product/produc_tags.dart';
import 'package:mygeneralshope/review/product_review.dart';

class Product {
  int product_id;
  String product_title, product_description;
  ProductUnit productUnit;
  double product_price, product_total, product_discount;
  ProductCategory productCategory;
  List<ProductTag> tags;
  List<String> images;
  List<ProductReview> reviews;

  Product(
      this.product_id,
      this.product_title,
      this.product_description,
      this.productUnit,
      this.product_price,
      this.product_total,
      this.product_discount,
      this.productCategory,
      this.tags,
      this.images,
      this.reviews);

  Product.fromJason(Map<String, dynamic> jasonObject) {
    if (jasonObject['product_id'] == null) {
      throw PropertyIsRequired('product_id');
    }

    if (jasonObject['product_title'] == null) {
      throw PropertyIsRequired('product_title');
    }

    if (jasonObject['product_description'] == null) {
      throw PropertyIsRequired('product_description');
    }
    if (jasonObject['product_price'] == null) {
      throw PropertyIsRequired('product_price');
    }
    if (jasonObject['product_discount'] == null) {
      throw PropertyIsRequired('product_discount');
    }
    if (jasonObject['product_total'] == null) {
      throw PropertyIsRequired('product_total');
    }

    if (jasonObject['product_category'] == null) {
      throw PropertyIsRequired('product_category');
    }
    if (jasonObject['product_images'] == null) {
      throw PropertyIsRequired('product_images');
    }
    if (jasonObject['product_images'] != null) {
      _setImages(jasonObject['product_images']);
    }

    this.product_id = jasonObject['product_id'];
    this.product_title = jasonObject['product_title'];
    this.product_description = jasonObject['product_description'];
    this.productUnit = jasonObject['product_unit'];
    this.product_price = double.tryParse(jasonObject['product_price']);
    this.product_total = double.tryParse(jasonObject['product_total']);
    this.product_discount = double.tryParse(jasonObject['product_discount']);
    this.productCategory =
        ProductCategory.fromjason(jasonObject['product_category']);

    if (jasonObject['product_tags'] == null) {
      _setTag(jasonObject['product_tags  ']);
    }
    if (jasonObject['product_images'] != null) {
      _setImages(jasonObject["product_images"]);
    }
    if (jasonObject['product_reviews'] != null) {
      _setReviews(jasonObject['product_reviews']);
    }

    _setTag(jasonObject['product_tags']);
    _setImages(jasonObject['product_images']);
    _setReviews(jasonObject['product_reviews']);
  }

  void _setReviews(List<dynamic> reviewarjason) {
    this.reviews = [];
    if (reviewarjason.length > 0) {
      for (var item in reviewarjason) {
        if (item != null) {
          this.reviews.add(ProductReview.fromJson(item));
        }
      }
    }
  }

  void _setTag(List<dynamic> tagsJson) {
    this.tags = [];
    if (tagsJson.length > 0) {
      for (var item in tagsJson) {
        if (item != null) {
          tags.add(ProductTag.formJason(item));
        }
      }
    }
  }

  void _setImages(List<dynamic> jsonimages) {
    this.images = [];
    if (jsonimages.length > 0) {
      for (var image in jsonimages) {
        if (image != null) {
          this.images.add(image['image_url']);
        }
      }
    }
  }

  String feachImage() {
    if (this.images.length > 0) {
      return this.images[0];
    }
    return 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';
  }
}
