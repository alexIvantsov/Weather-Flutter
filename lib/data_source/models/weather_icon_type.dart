/// Weather icons types used by OpenWeatherMap API.
///
/// See https://openweathermap.org/weather-conditions for more info.
enum WeatherIconType {
  clearSkyDay("01d"),
  clearSkyNight("01n"),
  fewCloudsDay("02d"),
  fewCloudsNight("02n"),
  scatteredCloudsDay("03d"),
  scatteredCloudsNight("03n"),
  brokenCloudsDay("04d"),
  brokenCloudsNight("04n"),
  showerRainDay("09d"),
  showerRainNight("09n"),
  rainDay("10d"),
  rainNight("10n"),
  thunderstormDay("11d"),
  thunderstormNight("11n"),
  snowDay("13d"),
  snowNight("13n"),
  mistDay("50d"),
  mistNight("50n");

  final String value;

  const WeatherIconType(this.value);

  static WeatherIconType fromValue(String value) {
    return WeatherIconType.values.firstWhere((e) => e.value == value);
  }
}
