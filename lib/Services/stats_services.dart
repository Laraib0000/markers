import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trigon_application/Model/abcd.dart';

import 'package:trigon_application/Services/api_urls.dart';
import 'dart:async';

class EVSStations {
  Future<Abcd> fetchEvsRecord() async {
    final response = await http.get(Uri.parse(AppUrl.baseUrl), headers: {
      'evApiKey': 'C3oXF1fT6GLW7Jasm9eIbHVDgMS2pq4EkPlyRr0uQzhUtx8Ocd',
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('All record: ${data}');

      return Abcd.fromJson(data);
    } else {
      throw Exception('Failed');
    }
    // return throw Exception('Failed');
  }
}
