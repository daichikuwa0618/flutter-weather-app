import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_training/data/weather.dart';
import 'package:flutter_training/data/weather_condition.dart';
import 'package:flutter_training/weather/use_case/get_weather.dart';
import 'package:flutter_training/weather/weather_icon.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen(
    GetWeather getWeather, {
    required VoidCallback close,
    super.key,
  })  : _getWeather = getWeather,
        _close = close;

  final GetWeather _getWeather;
  final VoidCallback _close;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Weather? _weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              // NOTE: [_ForecastContent] を上下中央に表示するために
              //       [flex: 1] を設定してある [Spacer] および [Expanded] で挟んでいる。
              //       [Column] に要素を追加すると上下中央のレイアウトが崩れるため注意。
              const Spacer(),
              _ForecastContent(
                weatherCondition: _weather?.condition,
                maxTemperature: _weather?.maxTemperature,
                minTemperature: _weather?.minTemperature,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: _ButtonsRow(
                      closeAction: widget._close,
                      reloadAction: _reloadWeather,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _reloadWeather() {
    try {
      final weather = widget._getWeather(area: 'tokyo');
      setState(() {
        _weather = weather;
      });
    } on GetWeatherException catch(e) {
      unawaited(_showErrorDialog(e.message));
    }
  }

  Future<void> _showErrorDialog(String message) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _ForecastContent extends StatelessWidget {
  const _ForecastContent({
    required WeatherCondition? weatherCondition,
    required int? maxTemperature,
    required int? minTemperature,
  })  : _weatherCondition = weatherCondition,
        _maxTemperature = maxTemperature,
        _mixTemperature = minTemperature;

  final WeatherCondition? _weatherCondition;
  final int? _maxTemperature;
  final int? _mixTemperature;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        WeatherIcon(
          weatherCondition: _weatherCondition,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${_mixTemperature ?? '**'} ℃',
                  textAlign: TextAlign.center,
                  style: textTheme.labelLarge?.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${_maxTemperature ?? '**'} ℃',
                  textAlign: TextAlign.center,
                  style: textTheme.labelLarge?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ButtonsRow extends StatelessWidget {
  const _ButtonsRow({
    required VoidCallback closeAction,
    required VoidCallback reloadAction,
  })  : _closeAction = closeAction,
        _reloadAction = reloadAction;

  final VoidCallback _closeAction;
  final VoidCallback _reloadAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: _closeAction,
            child: const Text(
              'Close',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: _reloadAction,
            child: const Text(
              'Reload',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

extension on GetWeatherException {
  String get message {
    return switch (this) {
      UnknownException() => 'Unknown error occurred. Please try again.',
      InvalidParameterException() =>
      'Parameter is not valid. Please check your inputs and try again.',
    };
  }
}
