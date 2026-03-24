class CommentAuthor {
  final String id;
  final String name;
  final String? profileSrc;

  CommentAuthor({required this.id, required this.name, this.profileSrc});

  factory CommentAuthor.fromJson(Map<String, dynamic> json) => CommentAuthor(
    id: json['id'],
    name: json['name'],
    profileSrc: json['profileSrc'],
  );
}

class Comment {
  final String id;
  final String content;
  final String? mediaUrl;
  final CommentAuthor author;
  final int likeCount;
  final DateTime createdAt;
  final bool isLiked;
  List<Comment> replys;

  Comment({
    required this.id,
    required this.content,
    this.mediaUrl,
    required this.author,
    required this.likeCount,
    required this.createdAt,
    required this.isLiked,
    List<Comment>? replys
  }) : replys = replys ?? [];

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json['id'],
    content: json['content'],
    mediaUrl: json['mediaUrl'],
    author: CommentAuthor.fromJson(json['author']),
    likeCount: json['_count']['likes'],
    createdAt: DateTime.parse(json['createdAt']),
    isLiked: json['isLiked'] ?? false,
  );
}