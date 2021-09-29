// import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MapData {
  Future getData() async {
    Response response =
        await get(Uri.parse('https://disease.sh/v3/covid-19/jhucsse'));
    Map data = jsonDecode(response.body);
    print(data);
    //map_data = map_data.sublist(249, 286);
  }
}
