import 'package:ex6/api/api_client.dart';
import 'package:ex6/api/api_response.dart';
import 'package:ex6/api/api_route.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/model/movie/movie_video.dart';
import 'package:ex6/model/tv/tv_credit.dart';
import 'package:ex6/model/tv/tv_detail.dart';
import 'package:ex6/model/tv/tv_popular.dart';
import 'package:ex6/model/tv/tv_recommendation.dart';

class TvRequest {
  final APIClient apiClient;
  TvRequest(this.apiClient);

  Future<TvDetail> fetchTvDetail(int tvId) async {
    final result = await apiClient.request<APIResponse<TvDetail>>(
        route: APIRoute(APIType.tv),
        extraPath: '/$tvId',
        create: () => APIResponse<TvDetail>(create: () => TvDetail())
    );
    final movie = result.response?.data;
    if (movie != null){
      return movie;
    }
    throw ErrorResponse(message: 'Tv detail not found');
  }

  Future<List<TvCastAndCrew>> fetchTvCast(int movieId) async {
    final result = await apiClient.request<APIResponse<TvCredit>>(
        route: APIRoute(APIType.tv),
        extraPath: '/$movieId/credits',
        create: () => APIResponse<TvCredit>(create: () => TvCredit())
    );
    var listTvCast = result.response?.data?.cast;
    if (listTvCast!=null) return listTvCast;
    throw ErrorResponse(message: 'Cast of TV not found');
  }

  Future<List<TvCastAndCrew>> fetchTvCrew(int movieId) async {
    final result = await apiClient.request<APIResponse<TvCredit>>(
        route: APIRoute(APIType.tv),
        extraPath: '/$movieId/credits',
        create: () => APIResponse<TvCredit>(create: () => TvCredit())
    );
    var listTvCrew = result.response?.data?.crew;
    if (listTvCrew!=null) return listTvCrew;
    throw ErrorResponse(message: 'Crew of TV not found');
  }

  Future<List<ResultVideoTrailer>> fetchTvVideo(int movieId) async {
    Map<String, dynamic> queryParameters = {
      'api_key': AppConfig.apiKey,
      'language': 'en',
    };
    final result = await apiClient.request<APIResponse<VideoTrailer>>(
        route: APIRoute(APIType.tv),
        extraPath: '/$movieId/videos',
        queryParam: queryParameters,
        create: () => APIResponse<VideoTrailer>(create: () => VideoTrailer())
    );
    var listTvVideo = result.response?.data?.results;
    if (listTvVideo!=null) return listTvVideo;
    throw ErrorResponse(message: 'Video of TV not found');
  }

  Future<List<TvRecommendationResult>> fetchTvResultRecommendation(int movieId) async {
    final result = await apiClient.request<APIResponse<TvRecommendation>>(
        route: APIRoute(APIType.tv),
        extraPath: '/$movieId/recommendations',
        create: () => APIResponse<TvRecommendation>(create: () => TvRecommendation())
    );
    var listTvRecommen = result.response?.data?.results;
    if (listTvRecommen!=null) return listTvRecommen;
    throw ErrorResponse(message: 'Tv recommendation not found');
  }

  Future<List<TvPopularResult>> fetchTvResultPopular({int page = 1}) async {
    Map<String, dynamic> baseQueryParameters = {
      'api_key': AppConfig.apiKey,
      'language': 'vi',
      'page': page
    };
    final result = await apiClient.request<APIResponse<TvPopular>>(
        route: APIRoute(APIType.tv),
        extraPath: '/popular',
        queryParam: baseQueryParameters,
        create: () =>
            APIResponse<TvPopular>(create: () => TvPopular())
    );
    var listTvPopular = result.response!.data?.results;
    if (listTvPopular!=null) return listTvPopular;
    throw ErrorResponse(message: 'Tv popular not found');
  }
}