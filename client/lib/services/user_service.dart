import 'package:client/data/models/api_user.dart';
import 'package:client/services/api_client.dart';

class UserService {
  String? currentUserId;

  Future<ApiUser> getMyProfile() async {
    final response = await dio.get('/api/users/me');
    final user = ApiUser.fromJson(response.data);
    currentUserId = user.id;
    return user;
  }
}

final userService = UserService();