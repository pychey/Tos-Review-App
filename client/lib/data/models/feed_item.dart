import 'package:client/data/models/ad.dart';
import 'package:client/data/models/post.dart';

sealed class FeedItem {}

class PostFeedItem extends FeedItem {
  final Post post;
  PostFeedItem(this.post);
}

class AdFeedItem extends FeedItem {
  final Ad ad;
  AdFeedItem(this.ad);
}