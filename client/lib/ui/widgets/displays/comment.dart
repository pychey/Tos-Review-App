import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'package:client/data/models/comment.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final Future<void> Function()? onLike;
  final Future<void> Function()? onEdit;
  final Future<void> Function()? onDelete;
  final String? currentUserId;

  const CommentWidget({super.key, required this.comment, this.onLike, this.onEdit, this.onDelete, this.currentUserId});

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
              onEdit?.call();
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Delete', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              onDelete?.call();
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
          Row(
            children: [
              ClipOval(
                child: comment.author.profileSrc != null
                ? Image.network(comment.author.profileSrc!, height: 40, width: 40, fit: BoxFit.cover)
                : Image.asset('assets/images/home/product1.png', height: 40, width: 40, fit: BoxFit.cover),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(comment.author.name, style: TosReviewTextStyles.body.copyWith(fontWeight: FontWeight.bold, color: TosReviewColors.greyDark)),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 50),
              Expanded(
                child: Text(comment.content, style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
              ),
            ],
          ),
          const SizedBox(height: TosReviewSpacings.s),
          Row(
            children: [
              const SizedBox(width: 50),
              Text(_timeAgo(comment.createdAt), style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
              const SizedBox(width: 10),
              Text("Reply", style: TosReviewTextStyles.body),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onLike,
                child: Icon(Icons.favorite, color: comment.isLiked ? Colors.red : TosReviewColors.greyDark, size: 20),
              ),
              const SizedBox(width: 5),
              Text('${comment.likeCount}', style: TosReviewTextStyles.body),
              const SizedBox(width: 10),
              if (comment.author.id == currentUserId)
                GestureDetector(
                  onTap: () => _showOptions(context),
                  child: Icon(Icons.more_horiz, size: 20),
                )
            ],
          )
        ],
      ),
    );
  }
}