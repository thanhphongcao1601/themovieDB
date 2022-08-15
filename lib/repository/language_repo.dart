// import 'package:ex6/api/api_client.dart';
// import 'package:ex6/api/api_route.dart';
// import 'package:ex6/model/language/language.dart';
//
// class LanguageRequest {
//   final APIClient apiClient;
//
//   LanguageRequest(this.apiClient);
//
//   Future<List<Language>> fetchListGenre() async {
//     final result = await apiClient.request<Language>(
//         route: APIRoute(APIType.listGenre),
//         create: () => GenreList()
//     );
//     var listMovieVideo = result.response?.genres;
//     if (listMovieVideo!=null) return listMovieVideo;
//     throw ErrorResponse(message: 'Genres not found');
//   }
// }