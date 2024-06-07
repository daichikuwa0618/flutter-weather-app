import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/weather.dart';
import 'package:flutter_training/infrastructure/weather_api.dart';
import 'package:flutter_training/weather/use_case/get_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../util/create_container.dart';
import 'get_weather_test.mocks.dart';

@GenerateNiceMocks([MockSpec<YumemiWeather>()])
void main() {
  late MockYumemiWeather mockYumemiWeather;

  setUp(() {
    mockYumemiWeather = MockYumemiWeather();
  });

  ProviderContainer createMockContainer() => createContainer(
        overrides: [
          yumemiWeatherProvider.overrideWith((ref) => mockYumemiWeather),
        ],
      );

  group('Test GetWeather UseCase', () {
    test('正常レスポンスで適切な Weather が返却される', () async {
      // Arrange
      final container = createMockContainer();
      final date = DateTime(2024, 4);
      final result = '''
      {
        "weather_condition":"cloudy",
        "max_temperature":25,
        "min_temperature":7,
        "date":"${date.toIso8601String()}"
      }
      ''';
      when(mockYumemiWeather.syncFetchWeather(any)).thenReturn(result);

      // Act
      final weather = await container.read(getWeatherProvider)(area: 'tokyo');

      // Assert
      expect(
        weather,
        Weather(
          condition: WeatherCondition.cloudy,
          maxTemperature: 25,
          minTemperature: 7,
          date: date,
        ),
      );
    });

    test('YumemiWeather.unknown の場合は UnknownException', () async {
      // Arrange
      final container = createMockContainer();
      when(mockYumemiWeather.syncFetchWeather(any))
          .thenThrow(YumemiWeatherError.unknown);

      // Act + Assert
      expect(
        () async => container.read(getWeatherProvider)(area: 'tokyo'),
        throwsA(isA<UnknownException>()),
      );
    });

    test('YumemiWeather.invalidParameter の場合は InvalidParameterException', () {
      // Arrange
      final container = createMockContainer();
      when(mockYumemiWeather.syncFetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      // Act + Assert
      expect(
        () async => container.read(getWeatherProvider)(area: 'tokyo'),
        throwsA(isA<InvalidParameterException>()),
      );
    });
  });
}
