import 'package:mygeneralshope/exception/excption.dart';

class CountryCity {
  int city_id;
  String city_name;

  CountryCity(this.city_id, this.city_name);

  CountryCity.fromjason(Map<String,dynamic>jasonObject){






    assert(jasonObject['city_id']!=null,'city_id is null');
    if(jasonObject['city_id']== null){
      throw PropertyIsRequired("city_id ");
    }

    assert(jasonObject['city_name']!=null,'city_name is null');
    if(jasonObject['city_name']== null){
      throw PropertyIsRequired("city_name ");
    }

    this.city_id=jasonObject['city_id'];
    this.city_name=jasonObject['city_name'];
  }


}
