import 'package:client/data/models/comment.dart';
import 'package:client/services/api_client.dart';

class CommentService {
  Future<List<Comment>> getComments(String postId) async {
    final response = await dio.get('/api/comments/$postId');
    final List data = response.data;
    return data.map((item) => Comment.fromJson(item)).toList();
  }

  Future<void> createComment(String postId, String content) async {
    await dio.post('/api/comments/$postId', data: {'content': content});
  }

  Future<Map> likeComment(String commentId) async {
    final response = await dio.post('/api/comments/like/$commentId');
    return response.data;
  }

  Future<void> updateComment(String commentId, String content) async {
    await dio.patch('/api/comments/$commentId', data: {'content': content});
  }

  Future<void> deleteComment(String commentId) async {
    await dio.delete('/api/comments/$commentId');
  }
}

final commentService = CommentService();