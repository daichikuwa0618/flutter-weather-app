import 'package:flutter_training/data/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final class GetWeather {
  const GetWeather();

  WeatherCondition execute() {
    final response = YumemiWeather().fetchSimpleWeather();
    return WeatherCondition.values.byName(response);
  }
}
