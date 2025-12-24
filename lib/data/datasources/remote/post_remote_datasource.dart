import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';
import '../../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts({int page = 1, int limit = 20});
  Future<PostModel> getPostById(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl(this.client);

  @override
  Future<List<PostModel>> getPosts({int page = 1, int limit = 20}) async {
    try {
      final response = await client
          .get(
            Uri.parse('${AppConstants.baseUrl}${AppConstants.postsEndpoint}'),
          )
          .timeout(
            const Duration(milliseconds: AppConstants.connectionTimeout),
          );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList =
            json.decode(response.body) as List<dynamic>;
        final List<PostModel> posts = jsonList
            .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Implement pagination on client side
        final startIndex = (page - 1) * limit;
        final endIndex = startIndex + limit;
        if (startIndex >= posts.length) {
          return [];
        }
        return posts.sublist(
          startIndex,
          endIndex > posts.length ? posts.length : endIndex,
        );
      } else {
        throw ServerFailure('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      }
      throw NetworkFailure('Network error: ${e.toString()}');
    }
  }

  @override
  Future<PostModel> getPostById(int id) async {
    try {
      final response = await client
          .get(
            Uri.parse(
              '${AppConstants.baseUrl}${AppConstants.postsEndpoint}/$id',
            ),
          )
          .timeout(
            const Duration(milliseconds: AppConstants.connectionTimeout),
          );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return PostModel.fromJson(json);
      } else if (response.statusCode == 404) {
        throw ServerFailure('Post not found');
      } else {
        throw ServerFailure('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      }
      throw NetworkFailure('Network error: ${e.toString()}');
    }
  }
}
