class AppConstants {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsEndpoint = '/posts';
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000;

  static const String authTokenKey = 'auth_token';
  static const String userEmailKey = 'user_email';
  static const String isLoggedInKey = 'is_logged_in';

  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minEmailLength = 5;
  static const int maxEmailLength = 100;

  static const int defaultPageSize = 20;
  static const int initialPage = 1;

  static const String mockEmail = 'user@example.com';
  static const String mockPassword = 'password123';
}
