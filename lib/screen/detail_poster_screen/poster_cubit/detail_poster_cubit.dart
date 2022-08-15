import 'package:ex6/repository/movie_repo.dart';
import 'package:ex6/repository/tv_repo.dart';
import 'package:ex6/screen/detail_poster_screen/poster_cubit/detail_poster_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPosterCubit extends Cubit<DetailPosterState> {
  final TvRequest tvRequest;
  final MovieRequest movieRequest;

  DetailPosterCubit(this.tvRequest, this.movieRequest)
      : super(const DetailPosterInitial());

  init(int pageIndex, int id){
    emit(const DetailPosterLoading());
    //Neu la trang TV
    if (pageIndex == 0) {
      tvRequest.fetchTvDetail(id).then((tvDetail) {
        emit(DetailPosterLoadedTvDetail(tvDetail));
      });
      tvRequest.fetchTvVideo(id).then((tvVideos) {
        emit(DetailPosterLoadedTvVideo(tvVideos));
      });
      tvRequest.fetchTvCrew(id).then((listTvCrews) {
        emit(DetailPosterLoadedTvCrews(listTvCrews));
      });
      tvRequest.fetchTvCast(id).then((listTvCasts) {
        emit(DetailPosterLoadedTvCasts(listTvCasts));
      });
      tvRequest.fetchTvResultRecommendation(id).then((listTvRecommendations) {
        emit(DetailPosterLoadedTvRecommendations(listTvRecommendations));
      });
      //Neu la Movie
    } else if (pageIndex == 1) {
      movieRequest.fetchMovieDetail(id).then((movieDetail) {
        emit(DetailPosterLoadedMovieDetail(movieDetail));
      });
      movieRequest.fetchMovieVideo(id).then((movieVideos) {
        emit(DetailPosterLoadedMovieVideo(movieVideos));
      });
      movieRequest.fetchMovieCrew(id).then((listMovieCrews) {
        emit(DetailPosterLoadedMovieCrews(listMovieCrews));
      });
      movieRequest.fetchMovieCast(id).then((listMovieCasts) {
        emit(DetailPosterLoadedMovieCasts(listMovieCasts));
      });
      movieRequest.fetchMovieResultRecommendation(id).then((listMovieReCommendations) {
        emit(DetailPosterLoadedMovieRecommendations(listMovieReCommendations));
      });
    }
  }
}
