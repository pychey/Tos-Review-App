class NotificationActor {
  final String id;
  final String name;
  final String? profileSrc;

  NotificationActor({required this.id, required this.name, this.profileSrc});

  factory NotificationActor.fromJson(Map<String, dynamic> json) => NotificationActor(
    id: json['id'],
    name: json['name'],
    profileSrc: json['profileSrc'],
  );
}

class NotificationPost {
  final String id;
  final String productName;
  final List<String> mediaUrls;

  NotificationPost({required this.id, required this.productName, required this.mediaUrls});

  factory NotificationPost.fromJson(Map<String, dynamic> json) => NotificationPost(
    id: json['id'],
    productName: json['productName'],
    mediaUrls: List<String>.from(json['mediaUrls'] ?? []),
  );
}

class AppNotification {
  final String id;
  final String type; // LIKE, COMMENT, FOLLOW, COMMENT_LIKE, RATING
  final bool isRead;
  final DateTime createdAt;
  final NotificationActor actor;
  final NotificationPost? post;

  AppNotification({
    required this.id,
    required this.type,
    required this.isRead,
    required this.createdAt,
    required this.actor,
    this.post,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
    id: json['id'],
    type: json['type'],
    isRead: json['isRead'] ?? false,
    createdAt: DateTime.parse(json['createdAt']),
    actor: NotificationActor.fromJson(json['actor']),
    post: json['post'] != null ? NotificationPost.fromJson(json['post']) : null,
  );

  String get message {
    switch (type) {
      case 'LIKE':
        return '${actor.name} liked your post';
      case 'COMMENT':
        return '${actor.name} commented on your post';
      case 'FOLLOW':
        return '${actor.name} started following you';
      case 'COMMENT_LIKE':
        return '${actor.name} liked your comment';
      case 'RATING':
        return '${actor.name} rated your post';
      default:
        return '${actor.name} interacted with you';
    }
  }

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}