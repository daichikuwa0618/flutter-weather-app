import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/util/after_layout_mixin.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({required AsyncCallback showWeather, super.key})
      : _showWeather = showWeather;

  final AsyncCallback _showWeather;

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with AfterLayoutMixin {
  @override
  Future<void> didLayoutEnded() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await widget._showWeather();
      // WeatherScreen にて "Close" が押された場合や iOS のエッジスワイプで戻った際に
      // 再度 WeatherScreen を表示するために再帰呼び出し
      await didLayoutEnded();
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
