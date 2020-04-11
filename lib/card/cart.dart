import 'package:mygeneralshope/product/product.dart';

class CartItem {
  Product product;
   double qty;

  CartItem(this.product, this.qty);

  CartItem.fromjason(Map<String, dynamic> jasonObject) {
    this.product = Product.fromJason(jasonObject['product']);
    this.qty = double.parse(jasonObject['qty']);
  }
}

class Cart {
  List<CartItem> cartItems;
  int id;
  double total;

  Cart(this.cartItems, this.id, this.total);

  Cart.fromJason(Map<String, dynamic> jasonObject) {
    cartItems = [];
    var items = jasonObject['cart_items'];
    for (var item in items) {
      cartItems.add((CartItem.fromjason(item)));
    }
    this.id = jasonObject['id'];
    this.total = jasonObject['total'];
  }
}
