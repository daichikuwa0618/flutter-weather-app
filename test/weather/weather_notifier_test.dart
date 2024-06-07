import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/weather.dart';
import 'package:flutter_training/weather/use_case/get_weather.dart';
import 'package:flutter_training/weather/weather_screen.dart';
import 'package:mockito/mockito.dart';

import '../util/create_container.dart';

class MockCallback extends Mock {
  void call(Weather? previous, Weather? next);
}

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

    final callback = MockCallback();
    when(callback.call(any, any)).thenReturn(null);

    final container = createContainer(
      overrides: [
        getWeatherProvider.overrideWith(
          (ref) => ({required area}) => results.removeAt(0).call(),
        ),
      ],
    );
    container.listen(
      weatherNotifierProvider,
      // `callback.call` をそのまま渡すと `container.listen` の方でエラーになる。
      // `MockCallback.call({Weather? previous, Weather? next})` のように名前付き引数にすると
      // 解決するものの、ここ以外が冗長な見た目になるので、ここだけ無視する。
      // ignore: unnecessary_lambdas
      (previous, next) => callback.call(previous, next),
    );

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
    verifyInOrder([
      callback.call(null, result1),
      callback.call(result1, result2),
      callback.call(result2, result3),
    ]);
  });
}
