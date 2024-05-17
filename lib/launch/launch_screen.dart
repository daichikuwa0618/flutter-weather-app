import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({required AsyncCallback showWeather, super.key})
      : _showWeather = showWeather;

  final AsyncCallback _showWeather;

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
      await widget._showWeather();
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
