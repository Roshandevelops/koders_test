import '../../core/constants/app_constants.dart';
import '../../core/error/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<Result<User>> login(String email, String password) async {
    try {
      if (email == AppConstants.mockEmail &&
          password == AppConstants.mockPassword) {
        final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';

        await localDataSource.saveAuthToken(token);
        await localDataSource.saveUserEmail(email);

        return Success(User(email: email, token: token));
      } else {
        return Error(AuthenticationFailure('Invalid email or password'));
      }
    } on CacheFailure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(AuthenticationFailure('Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await localDataSource.clearAuthData();
      return const Success(null);
    } on CacheFailure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(AuthenticationFailure('Logout failed: ${e.toString()}'));
    }
  }

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      final isLoggedIn = await localDataSource.isLoggedIn();
      if (!isLoggedIn) {
        return const Success(null);
      }

      final email = await localDataSource.getUserEmail();
      final token = await localDataSource.getAuthToken();

      if (email != null) {
        return Success(User(email: email, token: token));
      }

      return const Success(null);
    } on CacheFailure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(
        AuthenticationFailure('Failed to get current user: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<bool>> isLoggedIn() async {
    try {
      final loggedIn = await localDataSource.isLoggedIn();
      return Success(loggedIn);
    } on CacheFailure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(
        AuthenticationFailure('Failed to check login status: ${e.toString()}'),
      );
    }
  }
}
