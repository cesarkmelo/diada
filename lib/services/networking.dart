import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url, this.body);
  final String url;
  final Object body;

  Future getData() async {
    Uri netUrl = Uri.parse(url);
    http.Response response = await http.post(netUrl, body: body);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> data = json.decode(response.body);
      return data;
    } else {
      print(response.statusCode);
    }
  }

  Future storeData() async {
    Uri netUrl = Uri.parse(url);
    http.Response response = await http.post(netUrl, body: body);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> data = json.decode(response.body);
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
