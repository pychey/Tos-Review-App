import 'package:client/data/models/api_user.dart';
import 'package:client/services/api_client.dart';

class UserService {
  String? currentUserId;
  ApiUser? cachedUser;

  Future<ApiUser> getMyProfile() async {
    final response = await dio.get('/api/users/me');
    final user = ApiUser.fromJson(response.data);
    currentUserId = user.id;
    cachedUser = user;
    return user;
  }

  Future<List<String>> getInterests() async {
    final response = await dio.get('/api/users/me/interests');
    final List data = response.data;
    return data.map((item) => item['interest'] as String).toList();
  }

  Future<void> saveInterests(List<String> interests) async {
    await dio.post('/api/users/me/interests', data: {'interests': interests});
  }

  Future<void> updateProfile({
    required String name,
    String? bio,
    String? websiteUrl,
    String? profileSrc,
  }) async {
    await dio.patch('/api/users/me', data: {
      'name': name,
      if (bio != null) 'bio': bio,
      if (websiteUrl != null) 'websiteUrl': websiteUrl,
      if (profileSrc != null) 'profileSrc': profileSrc,
    });
  }

  Future<ApiUser> getUserProfile(String userId) async {
    final response = await dio.get('/api/users/$userId');
    return ApiUser.fromJson(response.data);
  }
}

final userService = UserService();