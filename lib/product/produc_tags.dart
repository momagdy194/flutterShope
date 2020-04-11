import 'package:mygeneralshope/exception/excption.dart';

class ProductTag{
  int tag_id;
  String tage_name;

  ProductTag(this.tag_id, this.tage_name);


  ProductTag.formJason(Map<String,dynamic>jsonObject){
    if(jsonObject['tag_id']== null){
      throw PropertyIsRequired("tag_id ");
    }
    if(jsonObject['tag_name']== null){
      throw PropertyIsRequired("tag_name ");
    }

    this.tag_id=jsonObject['tag_id'];
    this.tage_name=jsonObject['tage_name'];
  }

}