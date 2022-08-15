import 'package:ex6/repository/genres_repo.dart';
import 'package:ex6/repository/movie_repo.dart';
import 'package:ex6/screen/movie_screen/movie_cubit/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.movieRequest, this.genreRequest) : super(MovieInitial());
  final MovieRequest movieRequest;
  final GenreRequest genreRequest;
  int page = 1;

  fetchMorePopularMovie() {
    print('load page : $page');
    movieRequest.fetchMovieResultPopular(page: page)
        .then((listPopularMovie) {
      page++;
      emit(MoviePopularLoaded(listPopularMovie));
    });
  }

  fetchListGenre(){
    genreRequest.fetchListGenre().then((listGenre){
      emit(ListGenreLoaded(listGenre));
      print('load list genres');
    });
  }
}
