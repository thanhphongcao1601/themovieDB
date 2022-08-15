import 'package:ex6/helper/helper_function.dart';
import 'package:ex6/repository/movie_repo.dart';
import 'package:ex6/repository/trending_repo.dart';
import 'package:ex6/repository/tv_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TvRequest tvRequest;
  final MovieRequest movieRequest;
  final TrendingRequest trendingRequest;

  int popularToggle = 0;
  int trendingToggle = 0;
  MediaType? currentToggle = MediaType.TV;

  HomeCubit(this.tvRequest, this.movieRequest, this.trendingRequest)
      : super(const HomeInitial());

  init() {
    fetchPopularTv();
    fetchTrendingDay();
  }

  changePopularToggle(int index) {
    print('change toggle popular: $index');
    popularToggle = index;
    if (popularToggle == 0){
      currentToggle = MediaType.TV;
    }
    if (popularToggle ==1){
      currentToggle = MediaType.MOVIE;
    }
    emit(const HomePopularLoading());
  }

  fetchPopularTv() {
    print('fetch tv');
    tvRequest.fetchTvResultPopular().then((listPopularTV) {
      emit(HomeLoadedPopularTv(listPopularTV));
    });
  }

  fetchPopularMovie() {
    print('fetch movie');
    movieRequest.fetchMovieResultPopular().then((listPopularMovie) {
      emit(HomeLoadedPopularMovie(listPopularMovie));
    });
  }

  changeTrendingToggle(int index) {
    print('change toggle trending: $index');
    trendingToggle = index;
    emit(const HomeTrendingLoading());
  }

  fetchTrendingDay() {
    print('fetch today');
    trendingRequest.fetchResultTrending('day').then((listTrendingDay) {
      emit(HomeLoadedTrendingToday(listTrendingDay));
    });
  }

  fetchTrendingWeek() {
    print('fetch week');
    trendingRequest.fetchResultTrending('week').then((listTrendingWeek) {
      emit(HomeLoadedTrendingThisWeek(listTrendingWeek));
    });
  }
}