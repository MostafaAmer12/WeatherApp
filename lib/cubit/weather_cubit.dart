import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_news_app/cubit/weather_states.dart';
import 'package:weather_news_app/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherCubit extends Cubit<weatherStates> {
  WeatherCubit(this.weatherservice) : super(InitialWeatherState());
  WeatherService weatherservice;
  String? cityName;
  WeatherModel? weatherModel;

  void getWeather({required String cityName}) async {
    emit(LoadingWeatherState());
    try {
      weatherModel = await weatherservice.getWeather(cityName: cityName);
      emit(SuccessWeatherState());
    } catch (e) {
      emit(FailureWeatherState());
    }
  }
}
