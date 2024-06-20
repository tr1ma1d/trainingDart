import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../widget/widgets.dart';
import '../model/crypto_coin.dart';

class CryptoCoinsRepo {
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get(
      'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR',
    );
    debugPrint(response.data.toString());

    // Преобразуем данные в список объектов CryptoCoin
    final data = response.data as Map<String, dynamic>;
    return data.entries.map((entry) {
      return CryptoCoin(currency: entry.key, value: entry.value);
    }).toList();
  }
}
