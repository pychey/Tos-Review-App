import 'package:client/services/api_client.dart';

class FollowService {
  Future<bool> isFollowing(String userId) async {
    final response = await dio.get('/api/follow/$userId/is-following');
    return response.data['isFollowing'];
  }

  Future<bool> followUser(String userId) async {
    final response = await dio.post('/api/follow/$userId');
    return response.data['following'];
  }

  Future<List<Map<String, dynamic>>> getFollowers(String userId) async {
    final response = await dio.get('/api/follow/$userId/followers');
    final List data = response.data;
    return data.map((item) => {
      'id': item['follower']['id'],
      'name': item['follower']['name'],
      'image': item['follower']['profileSrc'],
    }).toList().cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getFollowing(String userId) async {
    final response = await dio.get('/api/follow/$userId/following');
    final List data = response.data;
    return data.map((item) => {
      'id': item['following']['id'],
      'name': item['following']['name'],
      'image': item['following']['profileSrc'],
    }).toList().cast<Map<String, dynamic>>();
  }
}

final followService = FollowService();