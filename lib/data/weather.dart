import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

part 'weather.g.dart';

enum WeatherCondition {
  sunny,
  rainy,
  cloudy;
}

@freezed
class Weather with _$Weather {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Weather({
    @_WeatherConditionConverter()
    @JsonKey(name: 'weather_condition')
    required WeatherCondition condition,
    required int maxTemperature,
    required int minTemperature,
    required DateTime date,
  }) = _Weather;

  factory Weather.fromJson(Map<String, Object?> json) =>
      _$WeatherFromJson(json);
}

class _WeatherConditionConverter
    implements JsonConverter<WeatherCondition, String> {
  const _WeatherConditionConverter();

  @override
  WeatherCondition fromJson(String json) {
    return WeatherCondition.values.byName(json);
  }

  @override
  String toJson(WeatherCondition weatherCondition) => weatherCondition.name;
}
