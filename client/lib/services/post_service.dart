import 'package:client/data/models/post.dart';
import 'package:client/services/api_client.dart';

class PostService {
  Future<List<Post>> getFeed({int page = 1, int limit = 10}) async {
    final response = await dio.get('/api/feed', queryParameters: {
      'page': page,
      'limit': limit,
    });
    final List data = response.data;
    return data
        .where((item) => item['type'] == 'POST')
        .map((item) => Post.fromJson(item))
        .toList();
  }

  Future<Post> getPostById(String id) async {
    final response = await dio.get('/api/posts/$id');
    return Post.fromJson(response.data);
  }

  Future<List<Post>> getRelatedPosts(String postId) async {
    final response = await dio.get('/api/posts/$postId/related');
    final List data = response.data;
    return data.map((item) => Post.fromJson(item)).toList();
  }

  Future<Map> likePost(String postId) async {
    final response = await dio.post('/api/interactions/like/$postId');
    return response.data;
  }

  Future<Map> savePost(String postId) async {
    final response = await dio.post('/api/interactions/save/$postId');
    return response.data;
  }

  Future<Map> ratePost(String postId, double value) async {
    final response = await dio.post('/api/interactions/rate/$postId', data: {'value': value});
    return response.data;
  }
}

final postService = PostService();