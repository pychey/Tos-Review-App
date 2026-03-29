class Ad {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? linkUrl;
  final String brandName;
  final String? brandLogo;
  final String status;
  final DateTime createdAt;

  Ad({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.linkUrl,
    required this.brandName,
    this.brandLogo,
    required this.status,
    required this.createdAt,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        linkUrl: json['linkUrl'],
        brandName: json['brandName'],
        brandLogo: json['brandLogo'],
        status: json['status'],
        createdAt: DateTime.parse(json['createdAt']),
      );
}