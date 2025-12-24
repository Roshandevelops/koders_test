import 'package:flutter/foundation.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/posts/get_post_by_id_usecase.dart';
import '../../domain/usecases/posts/get_posts_usecase.dart';

enum PostStatus { initial, loading, loaded, error, loadingMore }

class PostProvider with ChangeNotifier {
  final GetPostsUseCase getPostsUseCase;
  final GetPostByIdUseCase getPostByIdUseCase;

  PostProvider({
    required this.getPostsUseCase,
    required this.getPostByIdUseCase,
  });

  PostStatus _status = PostStatus.initial;
  List<Post> _posts = [];
  int _currentPage = AppConstants.initialPage;
  bool _hasMore = true;
  String? _errorMessage;

  PostStatus get status => _status;
  List<Post> get posts => _posts;
  bool get hasMore => _hasMore;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == PostStatus.loading;
  bool get isLoadingMore => _status == PostStatus.loadingMore;

  Future<void> loadPosts({bool refresh = false}) async {
    // Prevent multiple simultaneous loads
    if (!refresh && (_status == PostStatus.loadingMore || !_hasMore)) {
      return;
    }

    if (refresh) {
      _currentPage = AppConstants.initialPage;
      _posts = [];
      _hasMore = true;
      _status = PostStatus.loading;
    } else {
      _status = PostStatus.loadingMore;
    }

    _errorMessage = null;
    notifyListeners();

    final result = await getPostsUseCase(
      page: _currentPage,
      limit: AppConstants.defaultPageSize,
    );

    result.when(
      success: (newPosts) {
        if (refresh) {
          _posts = newPosts;
        } else {
          _posts.addAll(newPosts);
        }

        // Check if we have more posts to load
        if (newPosts.length < AppConstants.defaultPageSize) {
          _hasMore = false;
        } else {
          _currentPage++;
        }

        _status = PostStatus.loaded;
        _errorMessage = null;
        notifyListeners();
      },
      error: (failure) {
        _status = PostStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
    );
  }

  Future<Post?> getPostById(int id) async {
    final result = await getPostByIdUseCase(id);

    return result.when(
      success: (post) => post,
      error: (failure) {
        _errorMessage = failure.message;
        notifyListeners();
        return null;
      },
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
