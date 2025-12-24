import '../../../core/utils/result.dart';
import '../../entities/post.dart';
import '../../repositories/post_repository.dart';

class GetPostByIdUseCase {
  final PostRepository repository;

  GetPostByIdUseCase(this.repository);

  Future<Result<Post>> call(int id) async {
    return await repository.getPostById(id);
  }
}

