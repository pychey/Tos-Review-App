import 'dart:async';
import 'package:client/services/user_service.dart';
import 'package:client/ui/screens/inspect_post/comment_view.dart';
import 'package:client/ui/screens/inspect_post/widget/post_image.dart';
import 'package:client/ui/screens/profile/user_profile.dart';
import 'package:client/ui/widgets/displays/review_post.dart';
import 'package:flutter/material.dart';
import 'package:client/data/models/post.dart';
import 'package:client/services/post_service.dart';
import 'package:flutter/services.dart';
import '../../../utils/animations_util.dart';
import '../../theme/theme.dart';
import '../../widgets/actions/small_button.dart';
import '../../widgets/displays/comment.dart';
import 'widget/rating.dart';
import 'package:client/data/models/comment.dart';
import 'package:client/services/comment_service.dart';

class InspectPost extends StatefulWidget {
  final String postId;
  const InspectPost({super.key, required this.postId});

  @override
  State<InspectPost> createState() => _InspectPostState();
}

class _InspectPostState extends State<InspectPost> {
  Post? _post;
  bool _isLoading = true;
  List<Comment> _comments = [];
  List<Post> _relatedPosts = [];
  bool _isLiked = false;
  bool _isSaved = false;
  double _userRating = 0;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  Future<void> _loadPost() async {
    try {
      final post = await postService.getPostById(widget.postId);
      final comments = await commentService.getComments(widget.postId);
      final relatedPosts = await postService.getRelatedPosts(widget.postId);
      setState(() {
        _post = post;
        _comments = comments;
        _relatedPosts = relatedPosts;
        _isLiked = post.isLiked;
        _isSaved = post.isSaved;
        _userRating = post.userRating ?? 0;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshComments() async {
    final updated = await commentService.getComments(widget.postId);
    setState(() {
      _comments = updated;
      _post = _post!.copyWith(count: PostCount(
        likes: _post!.count.likes,
        comments: updated.length,
        saves: _post!.count.saves,
        ratings: _post!.count.ratings,
      ));
    });
  }

  Future<void> _toggleLike() async {
    final result = await postService.likePost(widget.postId);
    setState(() {
      _isLiked = result['liked'];
      _post = _post!.copyWith(count: PostCount(
        likes: result['likeCount'],
        comments: _post!.count.comments,
        saves: _post!.count.saves,
        ratings: _post!.count.ratings,
      ));
    });
  }

  Future<void> _toggleSave() async {
    final result = await postService.savePost(widget.postId);
    setState(() => _isSaved = result['saved']);
  }

  Future<void> _onRate(int value) async {
    final result = await postService.ratePost(widget.postId, value.toDouble());
    setState(() {
      _userRating = value.toDouble();
      _post = _post!.copyWith(
        avgUserRating: result['avgUserRating']?.toDouble(),
        count: PostCount(
          likes: _post!.count.likes,
          comments: _post!.count.comments,
          saves: _post!.count.saves,
          ratings: result['ratingCount'] ?? _post!.count.ratings,
        ),
      );
    });
  }

  Future<void> _sendComment(String content) async {
    if (content.trim().isEmpty) return;
    await commentService.createComment(widget.postId, content.trim());
    await _refreshComments();
  }

  Future<void> _deleteComment(String commentId) async {
    await commentService.deleteComment(commentId);
    await _refreshComments();
  }

  Future<void> _likeComment(String commentId) async {
    await commentService.likeComment(commentId);
    await _refreshComments();
  }

  Future<void> _editComment(String commentId, String content) async {
    await commentService.updateComment(commentId, content);
    await _refreshComments();
  }

  Future<void> _showEditSheet(String commentId, String currentContent) async {
    final controller = TextEditingController(text: currentContent);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'Edit comment'),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await _editComment(commentId, controller.text.trim());
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSeeMore() async {
    await Navigator.push(
      context,
      AnimationUtils.slideBTHalfScreen(
        CommentView(
          comments: _comments,
          postId: widget.postId,
          onSend: _sendComment,
          onDelete: _deleteComment,
          onLike: _likeComment,
          onEdit: (commentId, content) => _showEditSheet(commentId, content),
          currentUserId: userService.currentUserId,
        ),
      ),
    );
    await _refreshComments();
  }

  void _showReportSheet() {
    String? selectedReason;
    final detailsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: 20, right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report Post', style: TosReviewTextStyles.titleBold),
              const SizedBox(height: 12),
              ...['SPAM', 'INAPPROPRIATE', 'FAKE', 'OTHER'].map((reason) =>
                RadioListTile<String>(
                  title: Text(reason),
                  value: reason,
                  groupValue: selectedReason,
                  activeColor: TosReviewColors.primary,
                  onChanged: (val) => setSheetState(() => selectedReason = val),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(
                  hintText: 'Additional details (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: TosReviewColors.primary),
                  onPressed: selectedReason == null ? null : () async {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    Navigator.pop(context);
                    try {
                      await postService.reportPost(
                        widget.postId, selectedReason!,
                        details: detailsController.text,
                      );
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('Post reported successfully')),
                      );
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('You have already reported this post')),
                      );
                    }
                  },
                  child: const Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressPost(String postId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InspectPost(postId: postId)),
    );
  }

  Future<void> _sharePost() async {
    final link = await postService.getShareLink(widget.postId);
    await Clipboard.setData(ClipboardData(text: link));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link copied to clipboard')),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
        ? Center(child: CircularProgressIndicator(color: TosReviewColors.primary))
        : SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: TosReviewSpacings.paddingScreen, vertical: TosReviewSpacings.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back),
                  ),
                  const SizedBox(height: TosReviewSpacings.l),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.9,
                    child: PostImage(post: _post!, isLiked: _isLiked)
                  ),
                  const SizedBox(height: TosReviewSpacings.m),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Rating(onClick: _onRate, initialRating: _userRating.toInt()),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _toggleLike,
                            child: Icon(Icons.favorite, color: _isLiked ? Colors.red : Colors.black),
                          ),
                          const SizedBox(width: 10),
                          SmallButton(
                            onPress: _toggleSave,
                            name: _isSaved ? "Saved" : "Save",
                            isActive: !_isSaved,
                            width: 70,
                          ),
                          const SizedBox(width: 10),
                          if (_post!.author.id != userService.currentUserId)
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'report') _showReportSheet();
                                if (value == 'share') _sharePost();
                              },
                              itemBuilder: (_) => const [
                                PopupMenuItem(value: 'share', child: Text('Share')),
                                PopupMenuItem(value: 'report', child: Text('Report')),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: TosReviewSpacings.s),
                  GestureDetector(
                    onTap: () => _post?.author.id == null ? null : Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfile(userId: _post!.author.id!)),
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: _post?.author.profileSrc != null
                            ? Image.network(_post!.author.profileSrc!, height: 50, width: 50, fit: BoxFit.cover)
                            : Image.asset('assets/images/home/profile.png', height: 50, width: 50, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(_post?.author.name ?? '', style: TosReviewTextStyles.labelBold.copyWith(fontWeight: FontWeight.bold, color: TosReviewColors.greyDark)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TosReviewSpacings.s),
                  Text(_post?.productName ?? '', style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
                  Text(_post?.description ?? '', style: TosReviewTextStyles.body),
                  Text("Price: \$${_post?.price ?? ''}", style: TosReviewTextStyles.body),
                  const SizedBox(height: TosReviewSpacings.s),
                  Divider(),
                  const SizedBox(height: TosReviewSpacings.s),
                  Row(
                    children: [
                      Text("${_post?.count.comments ?? 0} comments", style: TosReviewTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                      Spacer(),
                      GestureDetector(
                        onTap: onSeeMore,
                        child: Text("see more", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark, decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                  const SizedBox(height: TosReviewSpacings.s),
                  ..._comments.take(2).map((c) => CommentWidget(
                    comment: c,
                    onLike: () => _likeComment(c.id),
                    onEdit: () => _showEditSheet(c.id, c.content),
                    onDelete: () => _deleteComment(c.id),
                    currentUserId: userService.currentUserId,
                  )),
                  const SizedBox(height: TosReviewSpacings.s),
                  Text("Related Product", style: TosReviewTextStyles.labelBold.copyWith(color: TosReviewColors.primary)),
                  GridView.builder(
                    itemCount: _relatedPosts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return ReviewPost(
                        onPress: () => onPressPost(_relatedPosts[index].id),
                        post: _relatedPosts[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}