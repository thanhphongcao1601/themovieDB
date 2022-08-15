import 'package:ex6/model/genre/genre.dart';
import 'package:ex6/model/movie/movie_popular.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MoviePopularLoading extends MovieState {}

class MoviePopularLoaded extends MovieState {
  final List<MoviePopularResult> listMoviePopular;
  MoviePopularLoaded(this.listMoviePopular);
}

class ListGenreLoaded extends MovieState {
  final List<GenreElement> listGenre;
  ListGenreLoaded(this.listGenre);
}

class MoviePopularError extends MovieState {}
