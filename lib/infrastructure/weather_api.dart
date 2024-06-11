import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_api.g.dart';

@riverpod
YumemiWeather yumemiWeather(YumemiWeatherRef ref) {
  return YumemiWeather();
}
