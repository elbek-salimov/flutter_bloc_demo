import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc_demo/data/models/countries_model.dart';
import 'package:http/http.dart' as http;
import 'network_response.dart';

class ApiProvider {
  static Future<NetworkResponse> getCountries() async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://all-countries.free.mockoapp.net/countries"));

      if (response.statusCode == HttpStatus.ok) {
        return NetworkResponse(
          data: (jsonDecode(response.body)["data"]["countries"] as List?)
              ?.map((e) => CountryModel.fromJson(e))
              .toList() ??
              [],
        );
      }
      return NetworkResponse(errorText: "Unknown error");
    } catch (error) {
      return NetworkResponse(errorText: error.toString());
    }
  }
}