import 'package:crypto_app/repo/crypro_coins/crypyo_coints_repo.dart';
import 'package:crypto_app/view/crypto_list_screen.dart';
import 'package:flutter/material.dart';
 // Исправлен импорт пути к репозиторию
import 'package:crypto_app/repo/model/crypto_coin.dart';
import 'dart:developer';

 // Импорт для использования функции log

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Исправлено на Key?

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        dividerColor: Colors.grey,
        useMaterial3: true,
        textTheme: const TextTheme(
          // Настройте текстовые темы при необходимости
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/coin': (context) => const CoinScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() {
    super.initState();
    _loadCryptoCoins(); // Вызываем метод загрузки данных при инициализации состояния
  }

  Future<void> _loadCryptoCoins() async {
    try {
      final coinsList = await CryptoCoinsRepo().getCoinsList();
      setState(() {
        _cryptoCoinsList = coinsList;
      });
    } catch (error) {
      log('Failed to load crypto coins: $error');
      // Можно добавить обработку ошибки, например, отображение сообщения пользователю
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x55555555),
        title: const Text("Crypto Currencies"),
        foregroundColor: Colors.white,
      ),
      body: (_cryptoCoinsList == null)
          ? const Center(child: CircularProgressIndicator()) // Отображаем индикатор загрузки пока данные не загружены
          : ListView.separated(
        itemCount: _cryptoCoinsList!.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          final coin = _cryptoCoinsList![i];
          final coinName = coin.currency.toString();
          final coinPrice = coin.value.toString(); // Получаем цену криптовалюты

          return ListTile(
            title: Text(
              coinName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              '\$$coinPrice', // Отображаем цену криптовалюты
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pushNamed('/coin', arguments: coinName);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh), // Изменили иконку на обновление

        onPressed: _loadCryptoCoins, // Вызываем метод загрузки данных при нажатии на кнопку

      ),
    );
  }
}
