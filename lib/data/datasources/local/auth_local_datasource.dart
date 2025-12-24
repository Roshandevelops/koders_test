import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthToken(String token);
  Future<void> saveUserEmail(String email);
  Future<String?> getAuthToken();
  Future<String?> getUserEmail();
  Future<bool> isLoggedIn();
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveAuthToken(String token) async {
    try {
      await sharedPreferences.setString(AppConstants.authTokenKey, token);
      await sharedPreferences.setBool(AppConstants.isLoggedInKey, true);
    } catch (e) {
      throw CacheFailure('Failed to save auth token: ${e.toString()}');
    }
  }

  @override
  Future<void> saveUserEmail(String email) async {
    try {
      await sharedPreferences.setString(AppConstants.userEmailKey, email);
    } catch (e) {
      throw CacheFailure('Failed to save user email: ${e.toString()}');
    }
  }

  @override
  Future<String?> getAuthToken() async {
    try {
      return sharedPreferences.getString(AppConstants.authTokenKey);
    } catch (e) {
      throw CacheFailure('Failed to get auth token: ${e.toString()}');
    }
  }

  @override
  Future<String?> getUserEmail() async {
    try {
      return sharedPreferences.getString(AppConstants.userEmailKey);
    } catch (e) {
      throw CacheFailure('Failed to get user email: ${e.toString()}');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      return sharedPreferences.getBool(AppConstants.isLoggedInKey) ?? false;
    } catch (e) {
      throw CacheFailure('Failed to check login status: ${e.toString()}');
    }
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await sharedPreferences.remove(AppConstants.authTokenKey);
      await sharedPreferences.remove(AppConstants.userEmailKey);
      await sharedPreferences.setBool(AppConstants.isLoggedInKey, false);
    } catch (e) {
      throw CacheFailure('Failed to clear auth data: ${e.toString()}');
    }
  }
}

