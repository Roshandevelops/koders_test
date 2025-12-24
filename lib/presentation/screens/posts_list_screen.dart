import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/post_card.dart';
import 'post_detail_screen.dart';
import '../../domain/entities/post.dart';

class PostsListScreen extends StatefulWidget {
  const PostsListScreen({super.key});

  @override
  State<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().loadPosts(refresh: true);
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Trigger pagination when user scrolls near the bottom (90% of the list)
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final threshold = maxScroll * 0.9;

    if (currentScroll >= threshold && maxScroll > 0) {
      final postProvider = context.read<PostProvider>();
      if (postProvider.hasMore && !postProvider.isLoadingMore) {
        postProvider.loadPosts();
      }
    }
  }

  void _navigateToDetail(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(postId: post.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, _) {
          if (postProvider.status == PostStatus.initial ||
              postProvider.status == PostStatus.loading) {
            return const LoadingWidget(message: 'Loading posts...');
          }

          if (postProvider.status == PostStatus.error &&
              postProvider.posts.isEmpty) {
            return ErrorDisplayWidget(
              message: postProvider.errorMessage ?? 'Failed to load posts',
              onRetry: () => postProvider.loadPosts(refresh: true),
            );
          }

          if (postProvider.posts.isEmpty) {
            return const EmptyWidget(
              message: 'No posts available',
              icon: Icons.article_outlined,
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await postProvider.loadPosts(refresh: true);
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: postProvider.posts.length +
                  (postProvider.isLoadingMore || (!postProvider.hasMore && postProvider.posts.isNotEmpty) ? 1 : 0),
              itemBuilder: (context, index) {
                // Show loading indicator at the bottom when loading more
                if (index == postProvider.posts.length) {
                  if (postProvider.isLoadingMore) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text('Loading more posts...'),
                          ],
                        ),
                      ),
                    );
                  } else if (!postProvider.hasMore) {
                    return const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          'No more posts to load',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    );
                  }
                }

                final post = postProvider.posts[index];
                return PostCard(
                  post: post,
                  onTap: () => _navigateToDetail(post),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

