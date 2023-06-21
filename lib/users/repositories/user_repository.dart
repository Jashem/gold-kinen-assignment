import 'package:assignment/core/exceptions.dart';
import 'package:assignment/users/models/user.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final Dio _dio;

  UserRepository(this._dio);

  Future<List<User>> getUsers() async {
    try {
      final res = await _dio.get("/users");
      final data = (res.data as List).map((e) => User.fromJson(e)).toList();
      return data;
    } on DioException catch (e) {
      throw AppException(
          message: "Server error", errorCode: e.response?.statusCode);
    } catch (e) {
      throw AppException(message: "Unknown error");
    }
  }
}
