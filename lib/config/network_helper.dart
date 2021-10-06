import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({
    required this.url,
    this.statusCode = 200,
  });

  final Uri url;
  final int statusCode;

  Future<Map<String, dynamic>> getData() async {
    //'$url$journeyMode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat'),
    final response = await http.get(url);
    print(url);

    if (response.statusCode == statusCode) {
      final data = response.body;
      return jsonDecode(data) as Map<String, dynamic>;
    } else {
      print(response.toString());
      throw NetWorkException(response.body);
    }
  }
}

class NetWorkException implements Exception {
  NetWorkException(this.cause);
  final String cause;
}
