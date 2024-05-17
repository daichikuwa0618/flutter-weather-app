import 'package:flutter_training/launch/launch_screen.dart';
import 'package:flutter_training/weather/use_case/get_weather.dart';
import 'package:flutter_training/weather/weather_screen.dart';
import 'package:go_router/go_router.dart';

const _path = (
  launch: '/',
  weather: '/weather',
);

final router = GoRouter(
  routes: [
    GoRoute(
      path: _path.launch,
      builder: (context, state) => LaunchScreen(
        showWeather: () => context.push(_path.weather),
      ),
    ),
    GoRoute(
      path: _path.weather,
      builder: (context, state) => WeatherScreen(
        const GetWeather(),
        close: () => context.pop(),
      ),
    ),
  ],
);
