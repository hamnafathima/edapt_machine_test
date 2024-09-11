import 'dart:convert';
import 'package:edapt_machine_test/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetServiceUtils {
  static Future<String> fetchData(String url, BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        AppUtils.showSnackBar(context, 'Error: ${response.reasonPhrase}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      AppUtils.showSnackBar(context, 'Error fetching data: $error');
      throw Exception('Error fetching data: $error');
    }
  }
}
