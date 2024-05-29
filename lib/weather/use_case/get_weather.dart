import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_training/data/weather.dart';
import 'package:flutter_training/infrastructure/weather_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'get_weather.freezed.dart';

part 'get_weather.g.dart';

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

typedef GetWeatherUseCase = Future<Weather> Function({required String area});

@riverpod
GetWeatherUseCase getWeather(GetWeatherRef ref) {
  return ({required area}) async {
    try {
      final request = _Request(area: area, dateTime: DateTime.now());
      final requestJsonString = jsonEncode(request.toJson());

      final yumemiWeather = ref.read(yumemiWeatherProvider);
      final rawResponse =
          await compute(yumemiWeather.syncFetchWeather, requestJsonString);
      final responseJson = jsonDecode(rawResponse) as Map<String, dynamic>;
      return Weather.fromJson(responseJson);
    } on YumemiWeatherError catch (e) {
      switch (e) {
        case YumemiWeatherError.unknown:
          throw UnknownException(rawError: e);

        case YumemiWeatherError.invalidParameter:
          throw InvalidParameterException(rawError: e);
      }
    } on Exception catch (_) {
      assert(false, 'Unexpected Exception');
      throw const UnknownException();
    }
  };
}

@Freezed(toJson: true)
class _Request with _$Request {
  const factory _Request({
    required String area,
    @JsonKey(name: 'date') required DateTime dateTime,
  }) = _RequestData;
}
