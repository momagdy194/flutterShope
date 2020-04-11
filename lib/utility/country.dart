import 'package:mygeneralshope/exception/excption.dart';

class Country {
  int country_id;
  String country_name, capital, currency;


  Country(this.country_id, this.country_name, this.capital, this.currency);

  Country.fromJason(Map<String,dynamic>jasonObject){

    assert(jasonObject['country_id']!=null,'country_id is null');
    if(jasonObject['country_id']== null){
      throw PropertyIsRequired("country_id ");
    }



    assert(jasonObject['country_name']!=null,'country_name is null');
    if(jasonObject['country_name']== null){
      throw PropertyIsRequired("country_name ");
    }

    assert(jasonObject['capital']!=null,'capital is null');
    if(jasonObject['capital']== null){
      throw PropertyIsRequired("capital ");
    }
    assert(jasonObject['currency']!=null,'currency is null');
    if(jasonObject['currency']== null){
      throw PropertyIsRequired("currency ");
    }


    this.country_id=jasonObject['country_id'];
    this.country_name=jasonObject['country_name'];
    this.capital=jasonObject['capital'];
    this.currency=jasonObject['currency'];

  }

}
