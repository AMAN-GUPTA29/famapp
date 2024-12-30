// fetching data from specified api

import 'dart:convert';
import 'package:http/http.dart' as http;

Future fetchApi() async {
  final response = await http.get(Uri.parse(
      'https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return "Error";
  }
}
