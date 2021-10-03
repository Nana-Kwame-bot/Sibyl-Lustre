import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sibly_lustre/constants/constants.dart';
import 'package:sibly_lustre/data/sunshine.dart';
import 'package:sibly_lustre/screens/report_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Sunshine> fetchData(
    {required http.Client client,
    String startDate = "",
    String endDate = ""}) async {
  if (startDate == "" && endDate == "") {
    startDate = DateFormat('yyyyMMdd').format(DateTime.now());
    endDate = DateFormat('yyyyMMdd').format(DateTime.now());
  }
  final response = await client.get(
    Uri.parse(
        '${Constants.baseUrl}/daily/${Constants.midUrl}&longitude=${positionData.longitude}&latitude=${positionData.latitude}&start=$startDate&end=$endDate&format=JSON'),
  );
  print(response.request);
  // Use the compute function to run parseJson in a separate isolate.
  return compute(parseJson, response.body);
}

// A function that converts a response body into Sunshine :) .
Sunshine parseJson(String responseBody) {
  final parsedJson = jsonDecode(responseBody);

  return Sunshine.fromJson(parsedJson);
}
