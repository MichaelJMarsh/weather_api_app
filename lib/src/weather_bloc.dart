import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_api_app/src/weather_model.dart';
import 'package:weather_api_app/src/weather_repo.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCityWeather extends WeatherEvent {
  final _city;

  FetchCityWeather(this._city);

  @override
  List<Object> get props => [_city];
}

class FetchZipCodeWeather extends WeatherEvent {
  final _zipCode;

  FetchZipCodeWeather(this._zipCode);

  @override
  List<Object> get props => [_zipCode];
}

class ResetWeather extends WeatherEvent {}

class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final _weather;

  WeatherIsLoaded(this._weather);

  WeatherModel get getWeather => _weather;

  @override
  List<Object> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherIsNotSearched());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // if city
    if (event is FetchCityWeather) {
      yield WeatherIsLoading();

      try {
        WeatherModel weather = await weatherRepo.getCityWeather(event._city);
        yield WeatherIsLoaded(weather);
      } catch (_) {
        print(_);
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }

    // if zip code
    if (event is FetchZipCodeWeather) {
      yield WeatherIsLoading();

      try {
        WeatherModel weather =
            await weatherRepo.getZipCodeWeather(event._zipCode);
        yield WeatherIsLoaded(weather);
      } catch (_) {
        print(_);
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
