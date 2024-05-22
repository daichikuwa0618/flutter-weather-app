import 'package:flutter_training/data/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

sealed class GetWeatherException implements Exception {
  const GetWeatherException({YumemiWeatherError? rawError})
      : _rawError = rawError;

  final YumemiWeatherError? _rawError;

  @override
  String toString() => _rawError.toString();
}

final class UnknownException extends GetWeatherException {
  const UnknownException({super.rawError});

  @override
  String toString() => 'Unknown Exception: ${super.toString()}';
}

final class InvalidParameterException extends GetWeatherException {
  const InvalidParameterException({super.rawError});

  @override
  String toString() => 'Parameter is not valid: ${super.toString()}';
}

final class GetWeather {
  const GetWeather();

  WeatherCondition call({required String area}) {
    try {
      final response = YumemiWeather().fetchThrowsWeather(area);
      return WeatherCondition.values.byName(response);
    } on YumemiWeatherError catch(e) {
      switch (e) {
        case YumemiWeatherError.unknown:
          throw UnknownException(rawError: e);

        case YumemiWeatherError.invalidParameter:
          throw InvalidParameterException(rawError: e);
      }
    } on Exception catch(_) {
      assert(false, 'Unexpected Exception');
      throw const UnknownException();
    }
  }
}
