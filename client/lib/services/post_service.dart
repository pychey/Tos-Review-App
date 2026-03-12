import 'package:client/data/models/post.dart';
import 'package:client/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<String> uploadFile(XFile file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.name),
    });
    final response = await dio.post('/api/upload', data: formData);
    return response.data['url'];
  }

  Future<void> createPost({
    required String productName,
    required String description,
    required double authorRating,
    required String category,
    required bool isAnonymous,
    double? price,
    String? location,
    String? productUrl,
    List<String> mediaUrls = const [],
  }) async {
    await dio.post('/api/posts', data: {
      'productName': productName,
      'description': description,
      'authorRating': authorRating,
      'category': category,
      'isAnonymous': isAnonymous,
      if (price != null) 'price': price,
      if (location != null && location.isNotEmpty) 'location': location,
      if (productUrl != null && productUrl.isNotEmpty) 'productUrl': productUrl,
      'mediaUrls': mediaUrls,
    });
  }

  Future<List<Post>> getMyPosts(String userId) async {
    final response = await dio.get('/api/posts/user/$userId');
    final List data = response.data;
    return data.map((item) => Post.fromJson(item)).toList();
  }

  Future<List<Post>> getSavedPosts() async {
    final response = await dio.get('/api/users/me/saves');
    final List data = response.data;
    return data.map((item) => Post.fromJson(item['post'])).toList();
  }

  Future<List<Post>> searchPosts(String query, {String? category}) async {
    final response = await dio.get('/api/posts/search', queryParameters: {
      'q': query,
      if (category != null) 'category': category,
    });
    final List data = response.data;
    return data.map((item) => Post.fromJson(item)).toList();
  }
}

final postService = PostService();