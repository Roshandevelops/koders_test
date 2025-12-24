import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/datasources/remote/post_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/usecases/auth/get_current_user_usecase.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/posts/get_post_by_id_usecase.dart';
import '../../domain/usecases/posts/get_posts_usecase.dart';

class DependencyInjection {
  static PostRemoteDataSource providePostRemoteDataSource() {
    return PostRemoteDataSourceImpl(http.Client());
  }

  static Future<AuthLocalDataSource> provideAuthLocalDataSource() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return AuthLocalDataSourceImpl(sharedPreferences);
  }

  static PostRepository providePostRepository() {
    return PostRepositoryImpl(providePostRemoteDataSource());
  }

  static Future<AuthRepository> provideAuthRepository() async {
    final localDataSource = await provideAuthLocalDataSource();
    return AuthRepositoryImpl(localDataSource);
  }

  static Future<LoginUseCase> provideLoginUseCase() async {
    final repository = await provideAuthRepository();
    return LoginUseCase(repository);
  }

  static Future<LogoutUseCase> provideLogoutUseCase() async {
    final repository = await provideAuthRepository();
    return LogoutUseCase(repository);
  }

  static Future<GetCurrentUserUseCase> provideGetCurrentUserUseCase() async {
    final repository = await provideAuthRepository();
    return GetCurrentUserUseCase(repository);
  }

  static GetPostsUseCase provideGetPostsUseCase() {
    final repository = providePostRepository();
    return GetPostsUseCase(repository);
  }

  static GetPostByIdUseCase provideGetPostByIdUseCase() {
    final repository = providePostRepository();
    return GetPostByIdUseCase(repository);
  }
}
