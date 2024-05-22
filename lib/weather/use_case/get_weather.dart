import 'dart:convert';
import 'package:flutter_training/data/weather.dart';
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

  Weather call({required String area}) {
    try {
      final request = _Request((area: area, dateTime: DateTime.now()));
      final requestJsonString = jsonEncode(request.toJson());

      final rawResponse = YumemiWeather().fetchWeather(requestJsonString);
      final responseJson = jsonDecode(rawResponse) as Map<String, dynamic>;
      final response = _Response.fromJson(responseJson);
      return Weather(
        condition: response.condition,
        maxTemperature: response.maxTemperature,
        minTemperature: response.minTemperature,
        date: response.date,
      );
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

extension type _Request(({String area, DateTime dateTime}) value) {
  Map<String, String> toJson() {
    return {
      'area': value.area,
      'date': value.dateTime.toString(),
    };
  }
}

class _Response {
  const _Response({
    required this.condition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory _Response.fromJson(Map<dynamic, dynamic> jsonString) {
    final conditionName = jsonString['weather_condition'].toString();
    final condition = WeatherCondition.values.byName(conditionName);
    final max = int.tryParse(jsonString['max_temperature'].toString());
    final min = int.tryParse(jsonString['min_temperature'].toString());
    final date = DateTime.tryParse(jsonString['date'].toString());

    if (max != null && min != null && date != null) {
      return _Response(
        condition: condition,
        maxTemperature: max,
        minTemperature: min,
        date: date,
      );
    } else {
      throw const FormatException();
    }
  }

  final WeatherCondition condition;
  final int maxTemperature;
  final int minTemperature;
  final DateTime date;
}
