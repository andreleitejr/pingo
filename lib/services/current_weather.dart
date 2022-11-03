import 'package:get/get.dart';
import 'package:pingo/constants/apis.dart';
import 'package:pingo/services/current_location.dart';
import 'package:weather/weather.dart';

class CurrentWeather {
  final CurrentLocation currentLocation = Get.find();
  final _weatherFactory = WeatherFactory(
    APIs.weather,
    language: Language.PORTUGUESE_BRAZIL,
  );

  Weather? weather;

  Future<void> init() async => await _getWeather();

  Future<void> _getWeather() async {
    List<Weather> forecast = await _weatherFactory.fiveDayForecastByLocation(
        currentLocation.currentCoordinates.latitude,
        currentLocation.currentCoordinates.longitude);

    weather = forecast.first;
  }

  String get icon =>
      'http://openweathermap.org/img/wn/${weather?.weatherIcon}@2x.png';
}
