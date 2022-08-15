import 'package:ex6/api/api_client.dart';
import 'package:ex6/api/api_response.dart';
import 'package:ex6/api/api_route.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/model/genre/genre.dart';

class GenreRequest {
  final APIClient apiClient;

  GenreRequest(this.apiClient);

  Future<List<GenreElement>> fetchListGenre() async {
    Map<String, dynamic> queryParameters = {
      'api_key': AppConfig.apiKey,
      'language': 'en'
    };
    final result = await apiClient.request<APIResponse<GenreList>>(
        route: APIRoute(APIType.listGenre),
        queryParam: queryParameters,
        create: () => APIResponse<GenreList>(create: () => GenreList())
    );
    var listMovieVideo = result.response?.data?.genres;
    if (listMovieVideo!=null) return listMovieVideo;
    throw ErrorResponse(message: 'Genres not found');
  }
}