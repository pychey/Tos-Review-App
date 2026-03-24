import 'package:client/data/models/post.dart';
import 'package:client/services/follow_service.dart';
import 'package:client/services/user_service.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ReviewPost extends StatefulWidget {
  final VoidCallback onPress;
  final Post post;
  final bool showAuthorInfo;
  const ReviewPost({super.key, required this.onPress, required this.post, this.showAuthorInfo = true});

  @override
  State<ReviewPost> createState() => _ReviewPostState();
}

class _ReviewPostState extends State<ReviewPost> {
  bool? _isFollowing;

  bool get _shouldShowFollowButton =>
      widget.post.author.id != null &&
      widget.post.author.id != userService.currentUserId;

  @override
  void initState() {
    super.initState();
    if (widget.showAuthorInfo && _shouldShowFollowButton) {
      _loadFollowStatus();
    }
  }

  Future<void> _loadFollowStatus() async {
    try {
      final result = await followService.isFollowing(widget.post.author.id!);
      if (mounted) setState(() => _isFollowing = result);
    } catch (_) {
      if (mounted) setState(() => _isFollowing = false);
    }
  }

  Future<void> _toggleFollow() async {
    try {
      final result = await followService.followUser(widget.post.author.id!);
      if (mounted) setState(() => _isFollowing = result);
    } catch (_) {}
  }

  OverlayEntry? _overlayEntry;
  void _showPopup(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50, // position of popup
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product name: ${widget.post.productName}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Description: ${widget.post.description}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Price: \$${widget.post.price}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Location: ${widget.post.location}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Likes: ${widget.post.count.likes}',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hidePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      onLongPressStart: (_) => _showPopup(context),  
      onLongPressEnd: (_) => _hidePopup(),     
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
            child: widget.post.mediaUrls.isNotEmpty
                ? Image.network(widget.post.mediaUrls[0], fit: BoxFit.cover, height: double.infinity, width: double.infinity)
                : Image.asset(
                    "assets/images/home/product1.png",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.15),
                    colorBlendMode: BlendMode.hardLight,
                  ),
          ),
          if (widget.post.avgUserRating != null)
            Positioned(
              top: 10,
              right: 10,
              child: Column(
                children: [
                  Icon(Icons.star, size: 25, color: Colors.yellow),
                  Text(
                    '${widget.post.avgUserRating!.toStringAsFixed(1)} (${widget.post.count.ratings})',
                    style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          if (widget.showAuthorInfo)
            Positioned(
              bottom: 0,
              left: 5,
              right: 5,
              child: Row(
                children: [
                  ClipOval(
                    child: widget.post.author.profileSrc != null
                        ? Image.network(widget.post.author.profileSrc!, height: 40, width: 40, fit: BoxFit.cover)
                        : Image.asset('assets/images/home/profile.png', height: 40, width: 40),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      widget.post.author.name,
                      style: TosReviewTextStyles.tooSmall.copyWith(color: TosReviewColors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (_shouldShowFollowButton)
                    _isFollowing == null
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : TextButton(
                            onPressed: _toggleFollow,
                            style: TextButton.styleFrom(
                              backgroundColor: _isFollowing! ? Colors.transparent : TosReviewColors.greyLight,
                              padding: const EdgeInsets.all(5),
                              minimumSize: Size.zero,
                              side: _isFollowing! ? const BorderSide(color: Colors.white) : BorderSide.none,
                            ),
                            child: Text(
                              _isFollowing! ? "Following" : "Follow",
                              style: TosReviewTextStyles.tooSmall.copyWith(
                                color: _isFollowing! ? Colors.white : TosReviewColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}