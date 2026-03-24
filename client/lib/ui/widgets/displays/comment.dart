import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'package:client/data/models/comment.dart';
import 'package:client/ui/screens/profile/user_profile.dart';
import 'package:client/ui/widgets/displays/reply.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final Future<void> Function()? onLike;
  final Future<void> Function()? onEdit;
  final Future<void> Function()? onDelete;
  final String? currentUserId;
  final VoidCallback? onReply;

  const CommentWidget({
    super.key,
    required this.comment,
    this.onLike,
    this.onEdit,
    this.onDelete,
    this.currentUserId,
    this.onReply,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _showReply = true;

  void _toggleReply() => setState(() => _showReply = !_showReply);

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} mn';
    if (diff.inHours < 24) return '${diff.inHours} hr';
    return '${diff.inDays} d';
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              widget.onEdit?.call();
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Delete', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              widget.onDelete?.call();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipOval(
              child: widget.comment.author.profileSrc != null
                  ? Image.network(widget.comment.author.profileSrc!,
                      height: 40, width: 40, fit: BoxFit.cover)
                  : Image.asset('assets/images/home/product1.png',
                      height: 40, width: 40, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text(widget.comment.author.name,
                    style: TosReviewTextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                        color: TosReviewColors.greyDark))),
            if (widget.comment.author.id == widget.currentUserId)
              GestureDetector(
                  onTap: () => _showOptions(context),
                  child: Icon(Icons.more_horiz)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.comment.content,
                  style: TosReviewTextStyles.body
                      .copyWith(color: TosReviewColors.greyDark)),
              Row(
                children: [
                  Text(_timeAgo(widget.comment.createdAt),
                      style: TosReviewTextStyles.body
                          .copyWith(color: TosReviewColors.greyDark)),
                  const SizedBox(width: 10),
                  GestureDetector(
                      onTap: widget.onReply, child: Text("Reply")),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: widget.onLike,
                    child: Icon(Icons.favorite,
                        color: widget.comment.isLiked
                            ? Colors.red
                            : TosReviewColors.greyDark,
                        size: 20),
                  ),
                  const SizedBox(width: 5),
                  Text('${widget.comment.likeCount}',
                      style: TosReviewTextStyles.body),
                ],
              ),
              if (widget.comment.replys.isNotEmpty)
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 10 ),
                  child: GestureDetector(
                      onTap: _toggleReply,
                      child: Text(_showReply ? "Hide replies" : "Show replies",
                          style: TosReviewTextStyles.body.copyWith(
                              color: TosReviewColors.greyDark))),
                ),
              if (_showReply)
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Column(
                    children: widget.comment.replys
                        .map((reply) => ReplyWidget(
                              comment: reply,
                              currentUserId: widget.currentUserId,
                            ))
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}