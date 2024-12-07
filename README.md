# weather

Mobile application to demonstrate skills in Flutter and Dart.  

![Weather App Demo](https://github.com/alexIvantsov/Weather-Flutter/blob/master/demo.gif)

## Used technologies
- Flutter bloc is used for state management.  
- GetIt + injectable are used for dependency injection.  
- Http package is used for network requests.  
- freezed + json_serializable are used for serialization and building models.  

## Getting Started

To build the app, the file with the API key must be created under the `lib/variables.dart`    
The file should look like this:  
```dart

const openWeatherMapApiKey = "YOUR_API_KEY";
```
Visit [OpenWeatherMap](https://openweathermap.org/api) to get the API key.

To build the app, run the commands:
```bash
flutter pub get
dart run build_runner build
flutter run
```