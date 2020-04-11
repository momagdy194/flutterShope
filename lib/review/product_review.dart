import 'package:mygeneralshope/review/reviewar.dart';

class ProductReview {
  int review_id, review_stars;
  String review;
  Reviewer reviewer;
  ProductReview(this.review_id, this.review_stars, this.review, this.reviewer);

  ProductReview.fromJson(Map<String,dynamic>jsonObject){
    this.review_id=jsonObject['review_id'];
    this.review_stars=jsonObject['review_stars'];
    this.review=jsonObject['review'];
    this.reviewer=Reviewer.fromjason(jsonObject['reviewer']);

  }
}
