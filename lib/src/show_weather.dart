import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_app/src/weather_bloc.dart';
import 'package:weather_api_app/src/weather_model.dart';

class ShowWeather extends StatelessWidget {
  final WeatherModel weather;
  final city;
  final zipCode;

  ShowWeather(
    this.weather,
    this.city,
    this.zipCode,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 32, left: 32, top: 10),
      child: Column(
        children: <Widget>[
          // Display Enter Search Parameter (either city or zipcode)
          Text(
            city ?? zipCode,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Current Temperature
          Text(
            weather.getTemp.round().toString() + "C",
            style: TextStyle(color: Colors.white70, fontSize: 50),
          ),
          Text(
            "Temprature",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  // Min Temprature
                  Text(
                    weather.getMinTemp.round().toString() + " C",
                    style: TextStyle(color: Colors.white70, fontSize: 30),
                  ),
                  Text(
                    "Min Temprature",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  // Max Temprature
                  Text(
                    weather.getMaxTemp.round().toString() + " C",
                    style: TextStyle(color: Colors.white70, fontSize: 30),
                  ),
                  Text(
                    "Max Temprature",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  // Current Humidity
                  Text(
                    weather.humidity.round().toString() + " %",
                    style: TextStyle(color: Colors.white70, fontSize: 30),
                  ),
                  Text(
                    "Humidity",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  // Current Pressure
                  Text(
                    weather.pressure.round().toString() + " hPa",
                    style: TextStyle(color: Colors.white70, fontSize: 30),
                  ),
                  Text(
                    "Pressure",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: () {
                BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
              },
              color: Colors.lightBlue,
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
