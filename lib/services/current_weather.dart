import 'package:get/get.dart';
import 'package:pingo/services/current_location.dart';
import 'package:weather/weather.dart';

class CurrentWeather {
  final CurrentLocation currentLocation = Get.find();
  final _weatherFactory = WeatherFactory(
    "026022dfb52c6a39c6d50911c3872f26",
    language: Language.PORTUGUESE_BRAZIL,
  );

  Temperature? temperature;

  Future<void> init() async {
    await _getWeather();
  }

  Future<void> _getWeather() async {
    List<Weather> forecast = await _weatherFactory.fiveDayForecastByLocation(
        currentLocation.currentCoordinates.latitude,
        currentLocation.currentCoordinates.longitude);

    temperature = forecast.first.temperature;
  }
}
