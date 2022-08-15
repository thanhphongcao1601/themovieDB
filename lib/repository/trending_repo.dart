import 'package:dio/dio.dart';
import 'package:ex6/api/api_client.dart';
import 'package:ex6/api/api_response.dart';
import 'package:ex6/api/api_route.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/model/trending/trending.dart';

Dio dio = Dio();

class TrendingRequest {
  final APIClient apiClient;

  TrendingRequest(this.apiClient);

  Future<List<TrendingResult>> fetchResultTrending(String dayOrWeek) async {
    Map<String, dynamic> baseQueryParameters = {
      'api_key': AppConfig.apiKey,
      'language': 'vi',
      'page': 1
    };
    final result = await apiClient.request<APIResponse<Trending>>(
        route: APIRoute(APIType.trending),
        extraPath: '/all/$dayOrWeek',
        queryParam: baseQueryParameters,
        create: () =>  APIResponse<Trending>(create: () => Trending())
    );
    var listTrending = result.response?.data?.results;
    if (listTrending!=null) return listTrending;
    throw ErrorResponse(message: 'Movie recommendation not found');
  }
}
