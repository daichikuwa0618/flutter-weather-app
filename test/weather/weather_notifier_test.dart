import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/weather.dart';
import 'package:flutter_training/weather/use_case/get_weather.dart';
import 'package:flutter_training/weather/weather_screen.dart';

import '../util/create_container.dart';

void main() {
  test('GetWeather の状態に応じて WeatherState が適切に更新される', () {
    final date = DateTime(2024, 4);
    final result1 = Weather(
      condition: WeatherCondition.cloudy,
      maxTemperature: 25,
      minTemperature: 7,
      date: date,
    );
    final result2 = Weather(
      condition: WeatherCondition.sunny,
      maxTemperature: 100,
      minTemperature: 7,
      date: date,
    );
    final result3 = Weather(
      condition: WeatherCondition.rainy,
      maxTemperature: 10,
      minTemperature: -7,
      date: date,
    );
    final results = [
      () => result1,
      () => result2,
      () => throw const UnknownException(),
      () => result3,
    ];
    final container = createContainer(
      overrides: [
        getWeatherProvider.overrideWith(
          (ref) => ({required area}) => results.removeAt(0).call(),
        ),
      ],
    );
    final history = <Weather?>[];
    container.listen(
      weatherNotifierProvider,
      (previous, next) => history.add(next),
    );
    final initialState = container.read(weatherNotifierProvider);
    expect(initialState, null); // 初期状態は null

    // Act
    container.read(weatherNotifierProvider.notifier).update(area: 'tokyo');
    container.read(weatherNotifierProvider.notifier).update(area: 'tokyo');
    expect(
      () => container
          .read(weatherNotifierProvider.notifier)
          .update(area: 'tokyo'),
      throwsA(isA<UnknownException>()),
    );
    container.read(weatherNotifierProvider.notifier).update(area: 'tokyo');

    // Assert
    final expectations = [result1, result2, result3];
    expect(history, expectations);
  });
}
