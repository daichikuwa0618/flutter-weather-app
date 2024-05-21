import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/data/weather.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, WeatherCondition? weatherCondition})
    : _weatherCondition = weatherCondition;

  final WeatherCondition? _weatherCondition;

  @override
  Widget build(BuildContext context) {
    final content = _weatherCondition != null
      ? SvgPicture.asset('assets/${_weatherCondition.name}.svg')
      : const Placeholder();
    return AspectRatio(
      aspectRatio: 1,
      child: content,
    );
  }
}
