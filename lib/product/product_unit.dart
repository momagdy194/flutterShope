import 'package:mygeneralshope/exception/excption.dart';

class ProductUnit{
  int unit_id;
  String unit_name,unit_code;

  ProductUnit(this.unit_id, this.unit_name, this.unit_code);

  ProductUnit.formJason(Map<String,dynamic>jsonObject){
    assert(jsonObject['unit_id'] !=null,'unit_id is null');
    if (jsonObject['unit_id'] == null) {
      throw PropertyIsRequired("unit_id ");
    }
    assert(jsonObject['unit_name']!=null,'unit_name is null');
    if (jsonObject['unit_name'] == null) {
      throw PropertyIsRequired("unit_name ");
    }
    assert(jsonObject['unit_code']!=null,'unit_code is null');
    if (jsonObject['unit_code'] == null) {
      throw PropertyIsRequired("unit_code ");
    }




    this.unit_id=jsonObject['unit_id'];
    this.unit_code=jsonObject['unit_code'];
    this.unit_name=jsonObject['unit_name'];
    
  }


}