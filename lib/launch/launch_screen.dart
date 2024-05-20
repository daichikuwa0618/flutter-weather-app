import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/util/layout_state_mixin.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({required AsyncCallback showWeather, super.key})
      : _showWeather = showWeather;

  final AsyncCallback _showWeather;

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with LayoutStateMixin {
  @override
  void didLayoutEnded() {
    unawaited(_showWeather());
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
    return const Scaffold(
      body: ColoredBox(
        color: Colors.green,
        child: SizedBox.expand(),
      ),
    );
  }
}
