import '../../../core/utils/result.dart';
import '../../entities/post.dart';
import '../../repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<Result<List<Post>>> call({int page = 1, int limit = 20}) async {
    return await repository.getPosts(page: page, limit: limit);
  }
}
