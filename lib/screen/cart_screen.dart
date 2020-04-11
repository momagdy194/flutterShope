

import 'package:flutter/material.dart';
import 'package:mygeneralshope/api/cart_api.dart';
import 'package:mygeneralshope/api/cart_api.dart';
import 'package:mygeneralshope/card/cart.dart';
import 'package:mygeneralshope/screen/utilities/helperWidgets.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
 CartApi cartApi=CartApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ScreenCart'),),
    body: FutureBuilder(future: cartApi.feachCart(),

        builder:(BuildContext context,AsyncSnapshot<Cart> snapshot){
      switch(snapshot.connectionState){
        case ConnectionState.none:
        case ConnectionState.waiting:
        case ConnectionState.active:
return CircularProgressIndicator();
        case ConnectionState.done:
          if(snapshot.hasError){
            return Text( snapshot.error.toString());
          }else if(snapshot.hasData){
            return  ListView.builder(itemCount: snapshot.data.cartItems.length,itemBuilder: (BuildContext context,int position){
return ListTile(
  title: Text(snapshot.data.cartItems[position].product.product_title),
);
            });
          }else {
            return Text('no data');
          }

          break;
      }return null;
    })
    );
  }
}
