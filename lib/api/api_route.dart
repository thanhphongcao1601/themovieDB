import 'package:dio/dio.dart';
import 'package:ex6/configs/constant.dart';

enum APIType { listLanguage, movie, tv, people, searchMulti, trending, newtoken, login, listGenre}

class APIRoute implements APIRouteConfigurable {
  final APIType type;
  final String? routeParams;

  APIRoute(this.type, {this.routeParams});

  /// Return config of api (method, url, header)
  @override
  RequestOptions? getConfig() {
    // extra for inteceptor check auth
    const authorize = {RequestExtraKeys.authorize: true};

    switch (type) {
      case APIType.listLanguage:
        return RequestOptions(
            path: '/configuration/languages', method: APIMethod.get, extra: authorize);
      case APIType.listGenre:
        return RequestOptions(
            path: '/genre/movie/list', method: APIMethod.get, extra: authorize);
      case APIType.newtoken:
        return RequestOptions(
            path: '/authentication', method: APIMethod.get, extra: authorize);
      case APIType.login:
        return RequestOptions(
            path: '/authentication', method: APIMethod.post, extra: authorize);
      case APIType.trending:
        return RequestOptions(
            path: '/trending', method: APIMethod.get, extra: authorize);
      case APIType.searchMulti:
        return RequestOptions(
            path: '/search/multi', method: APIMethod.get, extra: authorize);
      case APIType.people:
        return RequestOptions(
            path: '/person', method: APIMethod.get, extra: authorize);
      case APIType.movie:
        return RequestOptions(
          path: '/movie',
          method: APIMethod.get,
        );
      case APIType.tv:
        return RequestOptions(
          path: '/tv',
          method: APIMethod.get,
        );
      default:
        return null;
    }
  }
}

// ignore: one_member_abstracts
abstract class APIRouteConfigurable {
  RequestOptions? getConfig();
}

class APIMethod {
  static const get = 'get';
  static const post = 'post';
  static const put = 'put';
  static const patch = 'patch';
  static const delete = 'delete';
}
