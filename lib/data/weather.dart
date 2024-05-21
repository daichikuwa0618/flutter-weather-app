enum WeatherCondition {
  sunny, rainy, cloudy;
}

class Weather {
  const Weather({
    required this.condition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  final WeatherCondition condition;
  final int maxTemperature;
  final int minTemperature;
  final DateTime date;
}
