import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_test/flutter_svg_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/weather.dart';
import 'package:flutter_training/weather/use_case/get_weather.dart';
import 'package:flutter_training/weather/weather_screen.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  group('Test WeatherScreen', () {
    testWidgets('天気情報が未取得の場合は Placeholder', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: WeatherScreen(
              close: () {},
            ),
          ),
        ),
      );

      expect(find.byType(Placeholder), findsOneWidget);
      expect(find.text('** ℃'), findsNWidgets(2));
    });

    final cases = [
      (WeatherCondition.sunny, 'assets/sunny.svg'),
      (WeatherCondition.cloudy, 'assets/cloudy.svg'),
      (WeatherCondition.rainy, 'assets/rainy.svg'),
    ];

    for (final (condition, svg) in cases) {
      testWidgets('天気情報が ${condition.name} の場合に $svg が表示される', (tester) async {
        final weather = Weather(
          condition: WeatherCondition.sunny,
          maxTemperature: 100,
          minTemperature: 0,
          date: DateTime.now(),
        );
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(1080, 1920);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              getWeatherProvider.overrideWith(
                (ref) => ({required area}) async =>
                    weather.copyWith(condition: condition),
              ),
            ],
            child: MaterialApp(
              home: WeatherScreen(
                close: () {},
              ),
            ),
          ),
        );

        await tester.tap(find.text('Reload'));
        await tester.pumpAndSettle();

        final asset = SvgPicture.asset(svg);
        expect(find.svg(asset.bytesLoader), findsOneWidget);
        expect(find.text('100 ℃'), findsOneWidget);
        expect(find.text('0 ℃'), findsOneWidget);
      });
    }

    testWidgets('エラーダイアログ', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1080, 1920);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            getWeatherProvider.overrideWith(
              (ref) => ({required area}) => throw const UnknownException(
                    rawError: YumemiWeatherError.unknown,
                  ),
            ),
          ],
          child: MaterialApp(
            home: WeatherScreen(
              close: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.text('Reload'));
      // `CircularProgressIndicator` で `pumpAndSettle` だとタイムアウトになるので `pump` で代替
      await tester.pump(Durations.long1);

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
      expect(
        find.text('Unknown error occurred. Please try again.'),
        findsOneWidget,
      );
      expect(find.text('OK'), findsOneWidget);

      // OK ボタンタップでダイアログが閉じる
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
