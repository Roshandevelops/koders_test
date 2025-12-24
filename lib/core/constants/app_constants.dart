class AppConstants {
  // API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsEndpoint = '/posts';
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000;

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userEmailKey = 'user_email';
  static const String isLoggedInKey = 'is_logged_in';

  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minEmailLength = 5;
  static const int maxEmailLength = 100;

  // Pagination
  static const int defaultPageSize = 20;
  static const int initialPage = 1;

  // Mock Auth Credentials (for demo purposes)
  static const String mockEmail = 'user@example.com';
  static const String mockPassword = 'password123';
}
