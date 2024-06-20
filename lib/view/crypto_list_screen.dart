import 'package:flutter/material.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key});

  @override
  _CoinScreenState createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  String? coinName;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Получаем аргументы маршрута
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, "Most theme ...");
    // Проверяем на null и выводим сообщение
    // if (args != null && args is String) {
    //   log("its String");

    // } else {
    //   log("Its null or not a String");
    // }
    setState(() {
      coinName = args as String;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'),
      ),
      body: const Center(
        child: Text('Биточки',
          style: TextStyle(fontSize: 24),
        ),
      ),

    );

  }


}
