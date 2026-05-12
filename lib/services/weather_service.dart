import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  WeatherData({
    required this.temperature,
    required this.condition,
    required this.willRainTomorrow,
    required this.tomorrowMaxTemp,
  });

  final double temperature;
  final String condition;
  final bool willRainTomorrow;
  final double tomorrowMaxTemp;

  String get tempDisplay => '${temperature.round()}\u00b0';
  String get emoji {
    if (condition.contains('rain') || condition.contains('shower')) return '\ud83c\udf27\ufe0f';
    if (condition.contains('cloud')) return '\u26c5';
    if (condition.contains('clear')) return '\u2600\ufe0f';
    if (condition.contains('fog') || condition.contains('mist')) return '\ud83c\udf2b\ufe0f';
    return '\u26c5';
  }

  String get adviceTitle =>
      willRainTomorrow ? 'Skip watering today' : 'Water at base in the morning';
  String get adviceBody => willRainTomorrow
      ? 'Rain expected tomorrow will cover your Cherokee Carbon seedlings'
      : 'No rain forecast. A small drink at the soil line keeps roots active.';
}

class WeatherService {
  /// Fetches weather for given lat/lng using free Open-Meteo API.
  /// London defaults: lat 51.5074, lng -0.1278
  static Future<WeatherData> fetchWeather({
    double latitude = 51.5074,
    double longitude = -0.1278,
  }) async {
    final uri = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,weather_code'
      '&daily=weather_code,temperature_2m_max,precipitation_probability_max'
      '&timezone=auto'
      '&forecast_days=2',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Weather fetch failed: ${response.statusCode}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final current = json['current'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;
    final temp = (current['temperature_2m'] as num).toDouble();
    final code = current['weather_code'] as int;
    final tomorrowMax =
        ((daily['temperature_2m_max'] as List)[1] as num).toDouble();
    final tomorrowRainProb =
        ((daily['precipitation_probability_max'] as List)[1] as num)
            .toDouble();

    return WeatherData(
      temperature: temp,
      condition: _decodeWmoCode(code),
      willRainTomorrow: tomorrowRainProb >= 50,
      tomorrowMaxTemp: tomorrowMax,
    );
  }

  /// Convert WMO weather codes to human strings.
  /// See https://open-meteo.com/en/docs for code reference.
  static String _decodeWmoCode(int code) {
    if (code == 0) return 'clear sky';
    if (code <= 3) return 'partly cloudy';
    if (code <= 48) return 'foggy';
    if (code <= 57) return 'drizzle';
    if (code <= 67) return 'rain';
    if (code <= 77) return 'snow';
    if (code <= 82) return 'rain showers';
    if (code <= 86) return 'snow showers';
    return 'thunderstorm';
  }
}