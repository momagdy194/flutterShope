class ProductOption{
  String optionName;
  List<String>option;

  ProductOption(this.optionName, this.option);
  ProductOption.fromjason(List<Map<String,String>>jsonObject){
  option=[];
    for(var itemOptions in jsonObject){
    option.add(itemOptions.values.toString());
    }

  }

}