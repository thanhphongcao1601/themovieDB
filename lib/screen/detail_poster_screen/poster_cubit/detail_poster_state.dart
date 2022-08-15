import 'package:ex6/model/movie/movie_credit.dart';
import 'package:ex6/model/movie/movie_detail.dart';
import 'package:ex6/model/movie/movie_recommendation.dart';
import 'package:ex6/model/movie/movie_video.dart';
import 'package:ex6/model/tv/tv_credit.dart';
import 'package:ex6/model/tv/tv_detail.dart';
import 'package:ex6/model/tv/tv_recommendation.dart';

abstract class DetailPosterState {
  const DetailPosterState();
}

class DetailPosterInitial extends DetailPosterState {
  const DetailPosterInitial();
}
class DetailPosterLoading extends DetailPosterState {
  const DetailPosterLoading();
}

//TV
class DetailPosterLoadingTv extends DetailPosterState {
  const DetailPosterLoadingTv();
}

class DetailPosterLoadedTvVideo extends DetailPosterState {
  final List<ResultVideoTrailer> listTvVideo;

  DetailPosterLoadedTvVideo(this.listTvVideo);
}


class DetailPosterLoadedTvDetail extends DetailPosterState {
  final TvDetail tvDetail;
  DetailPosterLoadedTvDetail(this.tvDetail);
}

class DetailPosterLoadedTvCrews extends DetailPosterState {
  final List<TvCastAndCrew> listTvCrews;
  DetailPosterLoadedTvCrews(this.listTvCrews);
}

class DetailPosterLoadedTvCasts extends DetailPosterState {
  final List<TvCastAndCrew> listTvCasts;
  DetailPosterLoadedTvCasts(this.listTvCasts);
}

class DetailPosterLoadedTvRecommendations extends DetailPosterState {
  final List<TvRecommendationResult> listTvReCommendations;

  DetailPosterLoadedTvRecommendations(this.listTvReCommendations);
}

//MOVIE
class DetailPosterLoadingMovieDetail extends DetailPosterState {
  const DetailPosterLoadingMovieDetail();
}

class DetailPosterLoadingMovieVideo extends DetailPosterState {
  const DetailPosterLoadingMovieVideo();
}

class DetailPosterLoadingMovieCrews extends DetailPosterState {
  const DetailPosterLoadingMovieCrews();
}

class DetailPosterLoadingMovieCasts extends DetailPosterState {
  const DetailPosterLoadingMovieCasts();
}

class DetailPosterLoadingMovieRecommendations extends DetailPosterState {
  const DetailPosterLoadingMovieRecommendations();
}

class DetailPosterLoadedMovieDetail extends DetailPosterState {
  final MovieDetail movieDetail;

  DetailPosterLoadedMovieDetail(this.movieDetail);
}

class DetailPosterLoadedMovieCrews extends DetailPosterState {
  final List<MovieCastAndCrew> listMovieCrews;

  DetailPosterLoadedMovieCrews(this.listMovieCrews);
}

class DetailPosterLoadedMovieVideo extends DetailPosterState {
  final List<ResultVideoTrailer> listMovieVideo;

  DetailPosterLoadedMovieVideo(this.listMovieVideo);
}

class DetailPosterLoadedMovieCasts extends DetailPosterState {
  final List<MovieCastAndCrew> listMovieCasts;

  DetailPosterLoadedMovieCasts(this.listMovieCasts);
}

class DetailPosterLoadedMovieRecommendations extends DetailPosterState {
  final List<MovieRecommendationResult> listMovieReCommendations;

  DetailPosterLoadedMovieRecommendations(this.listMovieReCommendations);

}

class DetailPosterError extends DetailPosterState {
  const DetailPosterError();
}
