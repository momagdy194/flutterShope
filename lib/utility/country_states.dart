import 'package:mygeneralshope/exception/excption.dart';

class CountryState{
 int state_id;
 String state_name;

 CountryState.formjason(Map<String,dynamic>jasonObject){

   assert(jasonObject['state_id']!=null,'state_id is null');
   if(jasonObject['state_id']== null){
     throw PropertyIsRequired("state_id ");
   }

   assert(jasonObject['state_name']!=null,'state_name is null');
   if(jasonObject['state_name']== null){
     throw PropertyIsRequired("state_name ");
   }


   this.state_id=jasonObject['state_id'];
   this.state_name=jasonObject['state_name'];
 }

}