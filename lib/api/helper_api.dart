import 'dart:convert';
import 'package:connectivity/connectivity.dart';

import 'package:http/http.dart' as http;
import 'package:mygeneralshope/api/api_utill.dart';
import 'package:mygeneralshope/exception/excption.dart';
import 'package:mygeneralshope/product/produc_tags.dart';
import 'package:mygeneralshope/product/product_category.dart';
import 'package:mygeneralshope/utility/country.dart';
import 'package:mygeneralshope/utility/country_city.dart';
import 'package:mygeneralshope/utility/country_states.dart';

class HelperApi {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<List<ProductCategory>> fetchCategories() async {
    await checkInternet();

    String url = ApiUtl.CATEGORIES;
    http.Response response = await http.get(url, headers: headers);
    List<ProductCategory> categories = [];
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        var data = body['data'];
        for (var item in data) {
          categories.add(ProductCategory.fromjason(item));
        }
        break;

      case 404:
        ResourceNotFound('CATEgORIES');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
    }
    return categories;
  }

  Future<List<ProductTag>> fetchTags(int page) async {
    await checkInternet();

    String url = ApiUtl.TAGS + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    List<ProductTag> tags = [];
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        var data = body['data'];
        for (var item in data) {
          tags.add(ProductTag.formJason(item));
        }
        break;
      case 404:
        throw ResourceNotFound('TAGS');
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
    }
    return tags;
  }

  Future<List<Country>> fetchCountries(int page) async {
    await checkInternet();

    String url = ApiUtl.COUNTRIES + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    List<Country> countries = [];
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        var data = body['data'];
        for (var item in data) {
          countries.add(Country.fromJason(item));
        }
        break;
      case 404:
        throw ResourceNotFound('COUNTRIES');
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
    }
    return countries;
  }

  Future<List<CountryState>> fetchStates(int country, int page) async {
    await checkInternet();
    String url = ApiUtl.STATES(country) + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    List<CountryState> country_state = [];
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        var data = body['data'];
        for (var item in data) {
          country_state.add(CountryState.formjason(item));
        }
        break;
      case 404:
        throw ResourceNotFound('COUNTRY_STATE');
        break;

      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
    }
    return country_state;
  }

  Future<List<CountryCity>> fetchCities(int country, int page) async {
    await checkInternet();

    String url = ApiUtl.CITIES(country) + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    List<CountryCity> countery_city = [];

    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        var data = body['data'];

        for (var item in data) {
          countery_city.add(CountryCity.fromjason(item));
        }

        break;

      case 404:
        throw ResourceNotFound('COUNTRY_CITY');
        break;

      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
    }
    return countery_city;
  }
}
