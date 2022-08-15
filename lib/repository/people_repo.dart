import 'package:ex6/api/api_client.dart';
import 'package:ex6/api/api_response.dart';
import 'package:ex6/api/api_route.dart';
import 'package:ex6/model/people/people_combine_credit.dart';
import 'package:ex6/model/people/people_detail.dart';

class PeopleRequest {
  final APIClient apiClient;

  PeopleRequest(this.apiClient);

  Future<PeopleDetail> fetchPeopleDetail(int id) async {
    final result = await apiClient.request<APIResponse<PeopleDetail>>(
        route: APIRoute(APIType.people),
        extraPath: '/$id',
        create: () => APIResponse<PeopleDetail>(create: () => PeopleDetail())
    );
    final peopleDetail = result.response?.data;
    if (peopleDetail != null) {
      return peopleDetail;
    }
    throw ErrorResponse(message: 'People detail not found');
  }

  Future<PeopleCombineCredit> fetchPeopleCombineCredit(int id) async {
    final result = await apiClient.request<PeopleCombineCredit>(
        route: APIRoute(APIType.people),
        extraPath: '/$id/combined_credits',
        create: () => PeopleCombineCredit());
    var peopleCredit = result.response;
    if (peopleCredit != null) {
      return peopleCredit;
    }
    throw ErrorResponse(message: 'People detail not found');
  }
}
