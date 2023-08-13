import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_news_app/cubit/weather_cubit.dart';
import 'package:weather_news_app/cubit/weather_states.dart';
import 'package:weather_news_app/screens/search_screen.dart';

import '../models/weather_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:BlocProvider.of<WeatherCubit>(context).weatherModel == null
              ? Colors.blue
              :BlocProvider.of<WeatherCubit>(context).weatherModel!.getThemeColor() ,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchScreen();
                  }));
                },
                icon: Icon(Icons.search),
              ),
            ),
          ],
          title: Text(
            'Weather',
          ),
        ),
        body: BlocBuilder<WeatherCubit,weatherStates>(
          builder: (context, state) {
            if (state is LoadingWeatherState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SuccessWeatherState) {
              weatherData=BlocProvider.of<WeatherCubit>(context).weatherModel;
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    weatherData!.getThemeColor(),
                    weatherData!.getThemeColor()[300]!,
                    weatherData!.getThemeColor()[100]!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 4,
                      ),
                      Text(
                        BlocProvider.of<WeatherCubit>(context).cityName!,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Updated ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('${weatherData!.getImage()}'),
                          Text(
                            '${weatherData!.temp.toInt()}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'MaxTemp: ${weatherData!.maxTemp.toInt()}',
                              ),
                              Text(
                                'MinTemp: ${weatherData!.minTemp.toInt()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        weatherData!.weatherStateName,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(
                        flex: 6,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is FailureWeatherState) {
              return Center(
                child: Text('Searching Failure'),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'There is no Weather 😔',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Searching Now 🔍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
