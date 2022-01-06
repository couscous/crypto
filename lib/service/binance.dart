import 'dart:convert';
import 'package:crypto/model/coin.dart';
import 'package:http/http.dart' as http;

class HTTPService {
  static Future<Coin> fetchPrice(String symbol) async {
    final response = await http.get(Uri.parse(
        'https://api.binance.com/api/v3/ticker/price?symbol=$symbol'));

    if (response.statusCode == 200) {
      return Coin.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch price');
    }
  }
}
