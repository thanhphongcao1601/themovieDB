class RequestExtraKeys {
  static const String authorize = 'Authorize';
}

class AppConfig{
  static const String apiKey = 'd661b13a42da2c6a40b695cd17cbba7f';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String baseUrlImg = 'https://image.tmdb.org/t/p/w500';

  static const Map<String, dynamic> baseQueryParameters = {
    'api_key': apiKey,
    'language': 'en',
    'page': 1
  };
}

class AppColors{
  static const int darkBlue = 0xff0d253f;
  static const int lightBlue = 0xff01b4e4;
  static const int lightGreen = 0xff90cea1;
}