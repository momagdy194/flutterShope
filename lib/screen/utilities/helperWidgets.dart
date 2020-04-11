import 'package:flutter/material.dart';

Widget loading(){
  return Container(
    color: Colors.white,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget errore(String errore){
  return Container(
    child: Center(
      child: Text(errore, style: TextStyle(color: Colors.red),),
    ),
  );
}