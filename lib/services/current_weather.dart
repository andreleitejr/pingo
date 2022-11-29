import 'package:get/get.dart';
import 'package:pingo/constants/keys.dart';
import 'package:pingo/constants/design_animations.dart';
import 'package:pingo/services/current_location.dart';
import 'package:weather/weather.dart';

class CurrentWeather {
  final CurrentLocation currentLocation = Get.find();
  final _weatherFactory = WeatherFactory(
    APIKeys.weather,
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

  String get animation {
    if (weather?.weatherIcon == WeatherIcon.sun) {
      return 'sun';
    } else if (weather?.weatherIcon == WeatherIcon.fewClouds ||
        weather?.weatherIcon == WeatherIcon.fewCloudsNight) {
      return 'sun_with_cloud';
    } else if (weather?.weatherIcon == WeatherIcon.brokenClouds ||
        weather?.weatherIcon == WeatherIcon.brokenCloudsNight ||
        weather?.weatherIcon == WeatherIcon.scatteredClouds ||
        weather?.weatherIcon == WeatherIcon.scatteredCloudsNight) {
      return 'cloud';
    } else if (weather?.weatherIcon == WeatherIcon.rain ||
        weather?.weatherIcon == WeatherIcon.rainNight ||
        weather?.weatherIcon == WeatherIcon.showerRain) {
      return 'rain';
    } else {
      return 'sun';
    }
  }

  String get asset {
    if (weather?.weatherIcon == WeatherIcon.sun) {
      return DesignAnimations.sun;
    } else if (weather?.weatherIcon == WeatherIcon.fewClouds ||
        weather?.weatherIcon == WeatherIcon.fewCloudsNight) {
      return DesignAnimations.sunWithCloud;
    } else if (weather?.weatherIcon == WeatherIcon.brokenClouds ||
        weather?.weatherIcon == WeatherIcon.brokenCloudsNight ||
        weather?.weatherIcon == WeatherIcon.scatteredClouds ||
        weather?.weatherIcon == WeatherIcon.scatteredCloudsNight) {
      return DesignAnimations.cloud;
    } else if (weather?.weatherIcon == WeatherIcon.rain ||
        weather?.weatherIcon == WeatherIcon.rainNight ||
        weather?.weatherIcon == WeatherIcon.showerRain) {
      return DesignAnimations.rain;
    } else {
      return DesignAnimations.sun;
    }
  }
}

class WeatherIcon {
  static const sun = '01d';
  static const fewClouds = '02d';
  static const fewCloudsNight = '02n';
  static const scatteredClouds = '03d';
  static const scatteredCloudsNight = '03n';
  static const brokenClouds = '04d';
  static const brokenCloudsNight = '04n';
  static const showerRain = '09d';
  static const rain = '10d';
  static const rainNight = '10n';
  static const thunderstorm = '11d';
  static const mist = '50d';
}
