import '../../core/error/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/remote/post_remote_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<Post>>> getPosts({int page = 1, int limit = 20}) async {
    try {
      final posts = await remoteDataSource.getPosts(page: page, limit: limit);
      return Success(posts);
    } on ServerFailure catch (e) {
      return Error(e);
    } on NetworkFailure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get posts: ${e.toString()}'));
    }
  }

  @override
  Future<Result<Post>> getPostById(int id) async {
    try {
      final post = await remoteDataSource.getPostById(id);
      return Success(post);
    } on ServerFailure catch (e) {
      return Error(e);
    } on NetworkFailure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get post: ${e.toString()}'));
    }
  }
}
