import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_showWeatherAfterRendering);
  }

  Future<void> _showWeatherAfterRendering() async {
    await WidgetsBinding.instance.endOfFrame;
    await _showWeather();
  }

  Future<void> _showWeather() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await context.push('/weather');
      // WeatherScreen にて "Close" が押された場合や iOS のエッジスワイプで戻った際に
      // 再度 WeatherScreen を表示するために再帰呼び出し
      await _showWeather();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
