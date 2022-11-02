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

  Temperature? temperature;
  String? icon;

  Future<void> init() async => await _getWeather();

  Future<void> _getWeather() async {
    List<Weather> forecast = await _weatherFactory.fiveDayForecastByLocation(
        currentLocation.currentCoordinates.latitude,
        currentLocation.currentCoordinates.longitude);

    temperature = forecast.first.temperature;
    icon =
        "http://openweathermap.org/img/wn/${forecast.first.weatherIcon}@2x.png";
    print('ASDHUASDHAUHADSUHASDUSHU WATHEHRUD V ${icon}');
  }
}
