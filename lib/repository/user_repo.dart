import 'package:ex6/api/api_client.dart';
import 'package:ex6/api/api_response.dart';
import 'package:ex6/api/api_route.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/model/user_login/token_request.dart';
import 'package:ex6/model/user_login/user_login.dart';

class UserRequest {
  final APIClient apiClient;

  UserRequest(this.apiClient);

  Future<String> requestToken() async {
    Map<String, dynamic> queryParams = {"api_key": AppConfig.apiKey};

    final result = await apiClient.request<APIResponse<TokenRequest>>(
        route: APIRoute(APIType.newtoken),
        extraPath: '/token/new',
        create: () => APIResponse<TokenRequest>(create: () => TokenRequest()),
        queryParam: queryParams);

    print(result.response!.data!.requestToken!);
    return result.response!.data!.requestToken!;
  }

  Future<bool> requestTokenWithUsernameAndPassword(
      String username, String password, String requestToken) async {
    Map<String, dynamic> userLogin = UserLogin(
            username: username, password: password, requestToken: requestToken)
        .toJson();

    try{
      var result = await apiClient.instance?.post(
          '${AppConfig.baseUrl}/authentication/token/validate_with_login',
          queryParameters: {'api_key': AppConfig.apiKey},
          data: userLogin);
      if (result != null) {
        return result.data['success'];
      }
    }
    catch(e){}
    return false;
  }
}
