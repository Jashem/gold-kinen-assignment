import 'package:assignment/posts/models/post.dart';
import 'package:dio/dio.dart';

import '../../core/exceptions.dart';

class PostRepository {
  final Dio _dio;

  PostRepository(
    this._dio,
  );

  Future<List<Post>> getPostsByUserId(int id) async {
    try {
      final res = await _dio.get("/users/$id/posts");
      final data = (res.data as List).map((e) => Post.fromJson(e)).toList();
      return data;
    } on DioException catch (e) {
      throw AppException(
          message: "Server error", errorCode: e.response?.statusCode);
    } catch (e) {
      throw AppException(message: "Unknown error");
    }
  }

  Future<void> createPost({
    required int userId,
    required String title,
    required String body,
  }) async {
    try {
      final _ = await _dio.post("/posts", data: {
        "userId": userId,
        "title": title,
        "body": body,
      });
    } on DioException catch (e) {
      throw AppException(
          message: "Server error", errorCode: e.response?.statusCode);
    } catch (e) {
      throw AppException(message: "Unknown error");
    }
  }
}
