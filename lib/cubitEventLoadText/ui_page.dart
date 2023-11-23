import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather.dart';
import 'cubit.dart';

class WeatherSearchPage extends StatelessWidget {
  const WeatherSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.read<WeatherCubit>(); 
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Search"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Column(children: [
          ElevatedButton(onPressed: (){weatherCubit.getWeather('Kirov');}, child: const Text('Click')),

          BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return buildInitialInput();
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(state.weather);
            } else {
              // (state is WeatherError)
              return buildError();
            }
          },
        ),
        ],)
      ),
    );
  }
  
  Widget buildInitialInput() {
    return const Text('buildInitialInput');
  }
  
  Widget buildLoading() {
    return const Text('Loading');
  }

  Widget buildColumnWithData(Weather weather) {
    return  Text('${weather.cityName} / ${weather.temperatureCelsius}');
  }
  
  Widget buildError() {
    return const Text('Error');
  }
}
