class PostAuthor {
  final String? id;  // was: final String id
  final String name;
  final String? profileSrc;

  PostAuthor({this.id, required this.name, this.profileSrc});  // was: required this.id

  factory PostAuthor.fromJson(Map<String, dynamic> json) => PostAuthor(
    id: json['id'],      // no change needed, already handles null
    name: json['name'],
    profileSrc: json['profileSrc'],
  );
}

class PostCount {
  final int likes;
  final int comments;
  final int saves;
  final int ratings;

  PostCount({required this.likes, required this.comments, required this.saves, required this.ratings});

  factory PostCount.fromJson(Map<String, dynamic> json) => PostCount(
    likes: json['likes'] ?? 0,
    comments: json['comments'] ?? 0,
    saves: json['saves'] ?? 0,
    ratings: json['ratings'] ?? 0,
  );
}

class Post {
  final String id;
  final String productName;
  final String description;
  final double authorRating;
  final double? avgUserRating;
  final double? price;
  final String? location;
  final String? productUrl;
  final String category;
  final List<String> mediaUrls;
  final PostAuthor author;
  final PostCount count;
  final DateTime createdAt;
  final bool isLiked;
  final bool isSaved;
  final double? userRating;

  Post({
    required this.id,
    required this.productName,
    required this.description,
    required this.authorRating,
    this.avgUserRating,
    this.price,
    this.location,
    this.productUrl,
    required this.category,
    required this.mediaUrls,
    required this.author,
    required this.count,
    required this.createdAt,
    required this.isLiked,
    required this.isSaved,
    this.userRating,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'],
    productName: json['productName'],
    description: json['description'],
    authorRating: json['authorRating'].toDouble(),
    avgUserRating: json['avgUserRating']?.toDouble(),
    price: json['price']?.toDouble(),
    location: json['location'],
    productUrl: json['productUrl'],
    category: json['category'],
    mediaUrls: List<String>.from(json['mediaUrls'] ?? []),
    author: PostAuthor.fromJson(json['author']),
    count: PostCount.fromJson(json['_count']),
    createdAt: DateTime.parse(json['createdAt']),
    isLiked: json['isLiked'] ?? false,
    isSaved: json['isSaved'] ?? false,
    userRating: json['userRating']?.toDouble(),
  );

  Post copyWith({
    double? avgUserRating,
    bool? isLiked,
    bool? isSaved,
    double? userRating,
    PostCount? count,
  }) {
    return Post(
      id: id,
      productName: productName,
      description: description,
      authorRating: authorRating,
      avgUserRating: avgUserRating ?? this.avgUserRating,
      price: price,
      location: location,
      productUrl: productUrl,
      category: category,
      mediaUrls: mediaUrls,
      author: author,
      count: count ?? this.count,
      createdAt: createdAt,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      userRating: userRating ?? this.userRating,
    );
  }
}