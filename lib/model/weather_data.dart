import 'package:weather_watch/model/weather_data_current.dart';
import 'package:weather_watch/model/weather_data_daily.dart';
import 'package:weather_watch/model/weather_data_hourly.dart';

class WeatherData {

  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([this.current, this.hourly, this.daily]);

  // Function to fetch values 
  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
} 