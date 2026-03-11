class ApiUser {
  final String id;
  final String name;
  final String email;
  final String? bio;
  final String? websiteUrl;
  final String? profileSrc;
  final UserCount count;

  ApiUser({required this.id, required this.name, required this.email, this.bio, this.websiteUrl, this.profileSrc, required this.count});

  factory ApiUser.fromJson(Map<String, dynamic> json) => ApiUser(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    bio: json['bio'],
    websiteUrl: json['websiteUrl'],
    profileSrc: json['profileSrc'],
    count: UserCount.fromJson(json['_count']),
  );
}

class UserCount {
  final int posts;
  final int followers;
  final int following;

  UserCount({required this.posts, required this.followers, required this.following});

  factory UserCount.fromJson(Map<String, dynamic> json) => UserCount(
    posts: json['posts'],
    followers: json['followers'],
    following: json['following'],
  );
}