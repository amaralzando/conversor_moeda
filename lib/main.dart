import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:conversor_moeda/pages/Home_Converter.dart';
import 'package:conversor_moeda/pages/infomation_Converter.dart';

const request = 'https://api.hgbrasil.com/finance?key=5479c77b';

void main() async {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}