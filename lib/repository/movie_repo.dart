import 'package:ex6/api/api_client.dart';
import 'package:ex6/api/api_response.dart';
import 'package:ex6/api/api_route.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/model/movie/movie_credit.dart';
import 'package:ex6/model/movie/movie_detail.dart';
import 'package:ex6/model/movie/movie_popular.dart';
import 'package:ex6/model/movie/movie_recommendation.dart';
import 'package:ex6/model/movie/movie_video.dart';

class MovieRequest {
  final APIClient apiClient;
  MovieRequest(this.apiClient);

  Future<MovieDetail> fetchMovieDetail(int movieId) async {
    final result = await apiClient.request<APIResponse<MovieDetail>>(
        route: APIRoute(APIType.movie),
        extraPath: '/$movieId',
        create: () => APIResponse<MovieDetail>(create: () => MovieDetail())
    );
    final movie = result.response?.data;
    if (movie != null){
      return movie;
    }
    throw ErrorResponse(message: 'Movie detail not found');
  }

  Future<List<MovieCastAndCrew>> fetchMovieCast(int movieId) async {
    final result = await apiClient.request<APIResponse<MovieCredit>>(
        route: APIRoute(APIType.movie),
        extraPath: '/$movieId/credits',
        create: () => APIResponse<MovieCredit>(create: () => MovieCredit())
    );
    var listMovieCast = result.response?.data?.cast;
    if (listMovieCast!=null) return listMovieCast;
    throw ErrorResponse(message: 'Movie detail not found');
  }

  Future<List<MovieCastAndCrew>> fetchMovieCrew(int movieId) async {
    final result = await apiClient.request<APIResponse<MovieCredit>>(
        route: APIRoute(APIType.movie),
        extraPath: '/$movieId/credits',
        create: () => APIResponse<MovieCredit>(create: () => MovieCredit())
    );
    var listMovieCrew = result.response?.data?.crew;
    if (listMovieCrew!=null) return listMovieCrew;
    throw ErrorResponse(message: 'Movie detail not found');
  }

  Future<List<ResultVideoTrailer>> fetchMovieVideo(int movieId) async {
    Map<String, dynamic> queryParameters = {
      'api_key': AppConfig.apiKey,
      'language': 'en',
    };
    final result = await apiClient.request<APIResponse<VideoTrailer>>(
        route: APIRoute(APIType.movie),
        extraPath: '/$movieId/videos',
        queryParam: queryParameters,
        create: () => APIResponse<VideoTrailer>(create: () => VideoTrailer())
    );
    var listMovieVideo = result.response?.data?.results;
    if (listMovieVideo!=null) return listMovieVideo;
    throw ErrorResponse(message: 'Movie video not found');
  }

  Future<List<MovieRecommendationResult>> fetchMovieResultRecommendation(int movieId) async {
    final result = await apiClient.request<APIResponse<MovieRecommendation>>(
        route: APIRoute(APIType.movie),
        extraPath: '/$movieId/recommendations',
        create: () => APIResponse<MovieRecommendation>(create: () => MovieRecommendation())
    );
    var listMovieRecommen = result.response?.data?.results;
    if (listMovieRecommen!=null) return listMovieRecommen;
    throw ErrorResponse(message: 'Movie recommendation not found');
  }

  Future<List<MoviePopularResult>> fetchMovieResultPopular({int page = 1}) async {
    Map<String, dynamic> baseQueryParameters = {
      'api_key': AppConfig.apiKey,
      'language': 'en',
      'page': page
    };
    final result = await apiClient.request<APIResponse<MoviePopular>>(
        route: APIRoute(APIType.movie),
        extraPath: '/popular',
        queryParam: baseQueryParameters,
        create: () => APIResponse<MoviePopular>(create: () => MoviePopular())
    );
    var listMoviePopular = result.response?.data?.results;
    if (listMoviePopular!=null) return listMoviePopular;
    throw ErrorResponse(message: 'Movie recommendation not found');
  }

}
