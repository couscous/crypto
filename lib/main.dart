import 'dart:async';
import 'package:crypto/service/binance.dart';
import 'package:crypto/service/notifications.dart';
import 'package:crypto/model/coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const Crypto());
}

class Crypto extends StatefulWidget {
  const Crypto({Key? key}) : super(key: key);

  @override
  _CryptoState createState() => _CryptoState();
}

class _CryptoState extends State<Crypto> {
  late Future<Coin> futureCoin;
  late String symbol, price;

  @override
  void initState() {
    super.initState();
    futureCoin = HTTPService.fetchPrice("BTCUSDT");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFF343a40),
              secondary: const Color(0xFFFFC107))),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Crypto'),
        ),
        body: Center(
            child: CupertinoButton.filled(
                child: FutureBuilder<Coin>(
                  future: futureCoin,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      symbol = snapshot.data!.symbol;
                      price = snapshot.data!.price;
                      return Text(price);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
                onPressed: () {
                  Timer.periodic(const Duration(minutes: 1), (timer) {
                    NotificationService().showNotification(
                        0, symbol, "Currently exchanged at $price");
                  });
                })),
      ),
    );
  }
}
