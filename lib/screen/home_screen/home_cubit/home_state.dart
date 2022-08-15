
import 'package:ex6/model/movie/movie_popular.dart';
import 'package:ex6/model/trending/trending.dart';
import 'package:ex6/model/tv/tv_popular.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomePopularLoading extends HomeState {
  const HomePopularLoading();
}

class HomeTrendingLoading extends HomeState{
  const HomeTrendingLoading();
}

class HomeLoadedPopularTv extends HomeState {
  final List<TvPopularResult> listTvPopular;
  HomeLoadedPopularTv(this.listTvPopular);
}

class HomeLoadedPopularMovie extends HomeState {
  final List<MoviePopularResult> listMoviePopular;
  HomeLoadedPopularMovie(this.listMoviePopular);
}

class HomeLoadedTrendingToday extends HomeState {
  final List<TrendingResult> listTrendingDay;
  HomeLoadedTrendingToday(this.listTrendingDay);
}

class HomeLoadedTrendingThisWeek extends HomeState {
  final List<TrendingResult> listTrendingWeek;
  HomeLoadedTrendingThisWeek(this.listTrendingWeek);
}

class HomeError extends HomeState {
  const HomeError();
}
