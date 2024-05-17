import 'package:flutter/material.dart';
import 'package:flutter_training/data/weather_condition.dart';
import 'package:flutter_training/weather/use_case/get_weather.dart';
import 'package:flutter_training/weather/weather_icon.dart';
import 'package:go_router/go_router.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen(GetWeather getWeather, {super.key})
    : _getWeather = getWeather;

  final GetWeather _getWeather;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherCondition? _weatherCondition;

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
                weatherCondition: _weatherCondition,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: _ButtonsRow(
                      closeAction: () {
                        context.pop();
                      },
                      reloadAction: () {
                        final weatherCondition = widget._getWeather();
                        setState(() {
                          _weatherCondition = weatherCondition;
                        });
                      },
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
}

class _ForecastContent extends StatelessWidget {
  const _ForecastContent({WeatherCondition? weatherCondition})
    : _weatherCondition = weatherCondition;

  final WeatherCondition? _weatherCondition;

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
                  '** ℃',
                  textAlign: TextAlign.center,
                  style: textTheme.labelLarge?.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '** ℃',
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
  const _ButtonsRow({required VoidCallback closeAction, required VoidCallback reloadAction})
    : _closeAction = closeAction,
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
