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

  factory Weather.fromJson(Map<dynamic, dynamic> jsonString) {
    final conditionName = jsonString['weather_condition'].toString();
    final condition = WeatherCondition.values.byName(conditionName);
    final max = int.tryParse(jsonString['max_temperature'].toString());
    final min = int.tryParse(jsonString['min_temperature'].toString());
    final date = DateTime.tryParse(jsonString['date'].toString());

    if (max != null && min != null && date != null) {
      return Weather(
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
