import 'package:flutter/material.dart';
import 'package:mygeneralshope/product/product.dart';
import 'package:mygeneralshope/screen/login.dart';
import 'package:mygeneralshope/screen/utilities/colorutilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/cart_api.dart';

class SingleProduct extends StatefulWidget {
  final Product product;

  SingleProduct(this.product);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  CartApi cartApi = CartApi();
  bool _addingToCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.product.product_title),
        ),
        body: _drawScreen(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            int userId = pref.getInt('user_id');
            if (userId == null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            } else {
              setState(() {
                _addingToCart = true;
              });
              await cartApi.
              addProductToCard(widget.product.product_id);
              setState(() {
                _addingToCart = false;
              });
            }
          },
          child:(_addingToCart)?CircularProgressIndicator():Icon(Icons.add_shopping_cart),
          backgroundColor: ScreenUtilities.mainBlue,
        ));
  }

  Widget _drawScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height * .25,
              child: _drawImageGalery(context)),
          _drawTitle(context),
          SizedBox(
            height: 18,
          ),
          _drawDetails(context),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              color: Colors.blueGrey,
              height: 1,
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _drawImageGalery(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, int position) {
        return Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: NetworkImage(widget.product.feachImage()),
            fit: BoxFit.cover,
          ),
        ));
      },
      itemCount: widget.product.images.length,
    );
  }

  _drawTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.product_title,
                  style: Theme.of(context).textTheme.headline,
                ),
                SizedBox(height: 16),
                Text(widget.product.productCategory.category_name,
                    style: Theme.of(context).textTheme.subhead)
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(widget.product.product_price.toString() + ' \$',
                    style: Theme.of(context).textTheme.headline),
                SizedBox(height: 16),
                (widget.product.product_discount) > 0
                    ? Text(_Calculatediscoint() + ' \$',
                        style: Theme.of(context).textTheme.subhead)
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }

  String _Calculatediscoint() {
    double discoint = widget.product.product_discount;
    double price = widget.product.product_price;
    return (price * discoint).toString();
  }

  _drawDetails(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 16, left: 16),
        child: Text(
          widget.product.product_description,
          style: Theme.of(context).textTheme.display2,
        ));
  }
}
