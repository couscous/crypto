class Coin {
  final String symbol;
  final String price;

  Coin({
    required this.symbol,
    required this.price,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      symbol: json['symbol'],
      price: json['price'],
    );
  }
}
