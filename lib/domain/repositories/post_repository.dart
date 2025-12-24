import '../../core/utils/result.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Result<List<Post>>> getPosts({
    int page = 1,
    int limit = 10,
  });
  Future<Result<Post>> getPostById(int id);
}

