import 'package:flutter/material.dart';

import '../../../data/models/comment.dart';
import '../../screens/profile/user_profile.dart';
import '../../theme/theme.dart';

class ReplyWidget extends StatefulWidget {
  final Comment comment;
  final Future<void> Function()? onLike;
  final Future<void> Function()? onEdit;
  final Future<void> Function()? onDelete;
  final String? currentUserId;
  const ReplyWidget({super.key, required this.comment, this.onLike, this.onEdit, this.onDelete, this.currentUserId});

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
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
  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} mn';
    if (diff.inHours < 24) return '${diff.inHours} hr';
    return '${diff.inDays} d';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfile(userId: widget.comment.author.id)),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: widget.comment.author.profileSrc != null
                  ? Image.network(widget.comment.author.profileSrc!, height: 40, width: 40, fit: BoxFit.cover)
                  : Image.asset('assets/images/home/product1.png', height: 40, width: 40, fit: BoxFit.cover),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(widget.comment.author.name, style: TosReviewTextStyles.body.copyWith(fontWeight: FontWeight.bold, color: TosReviewColors.greyDark)),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 50),
              Expanded(
                child: Text(widget.comment.content, style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
              ),
            ],
          ),
          const SizedBox(height: TosReviewSpacings.s),
          Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 50),
                  Text(_timeAgo(widget.comment.createdAt), style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
                  const SizedBox(width: 10),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: widget.onLike,
                    child: Icon(Icons.favorite, color: widget.comment.isLiked ? Colors.red : TosReviewColors.greyDark, size: 20),
                  ),
                  const SizedBox(width: 5),
                  Text('${widget.comment.likeCount}', style: TosReviewTextStyles.body),
                  const SizedBox(width: 10),
                  if (widget.comment.author.id == widget.currentUserId)
                    GestureDetector(
                      onTap: () => _showOptions(context),
                      child: Icon(Icons.more_horiz, size: 20),
                    ),          
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}