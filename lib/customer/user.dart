import 'package:mygeneralshope/exception/excption.dart';

class User {
  // ignore: non_constant_identifier_names
  int user_id;

  // ignore: non_constant_identifier_names
  String first_name, last_name, email, api_token;

  User(this.user_id, this.first_name, this.last_name, this.email,
      [this.api_token]);

  User.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['user_id'] != null, 'user_id is null');
    if (jsonObject['user_id'] == null) {
      throw PropertyIsRequired("user_id ");
    }

    assert(jsonObject['first_name'] != null, 'first_name is null');
    if (jsonObject['first_name'] == null) {
      throw PropertyIsRequired("first_name ");
    }

    assert(jsonObject['email'] != null, 'email is null');
    if (jsonObject['email'] == null) {
      throw PropertyIsRequired("email ");
    }

    assert(jsonObject['api_token'] != null, 'api_token is null');
    if (jsonObject['api_token'] == null) {
      throw PropertyIsRequired("api_token ");
    }

    this.user_id = jsonObject['user_id'];
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.api_token = jsonObject['api_token'];
  }
}
