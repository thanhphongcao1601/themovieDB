import 'package:ex6/api/api_client.dart';
import 'package:ex6/api/api_response.dart';
import 'package:ex6/api/api_route.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/model/search/multi_search.dart';

class SearchRequest {
  final APIClient apiClient;

  SearchRequest(this.apiClient);

  Future<List<SearchResult>> fetchSearchMulti(String query,
      {int page = 1}) async {
    Map<String, dynamic> searchQueryParameters = {
      'api_key': AppConfig.apiKey,
      'page': 1,
      'query': query
    };
    final result = await apiClient.request<APIResponse<MultiSearch>>(
        route: APIRoute(APIType.searchMulti),
        queryParam: searchQueryParameters,
        create: () => APIResponse<MultiSearch>(create: () => MultiSearch())
    );
    var listSearch = result.response?.data?.results;
    if (listSearch!=null) return listSearch;
    throw ErrorResponse(message: 'Search not found');
  }
}
