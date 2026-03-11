import 'package:client/data/models/comment.dart';
import 'package:client/services/comment_service.dart';
import 'package:client/ui/theme/theme.dart';
import 'package:client/ui/widgets/displays/comment.dart';
import 'package:flutter/material.dart';

class CommentView extends StatefulWidget {
  final List<Comment> comments;
  final String postId;
  final Future<void> Function(String) onSend;
  final Future<void> Function(String) onDelete;
  final Future<void> Function(String) onLike;
  final Future<void> Function(String, String) onEdit;
  final String? currentUserId;

  const CommentView({
    super.key,
    required this.comments,
    required this.postId,
    required this.onSend,
    required this.onDelete,
    required this.onLike,
    required this.onEdit, 
    this.currentUserId,
  });

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final TextEditingController commentController = TextEditingController();

  List<Comment> _localComments = [];

  @override
  void initState() {
    super.initState();
    _localComments = widget.comments;
  }

  Future<void> _refreshComments() async {
    final updated = await commentService.getComments(widget.postId);
    setState(() => _localComments = updated);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: TosReviewColors.primary,
            ),
            child: Text('${_localComments.length} comments', style: TosReviewTextStyles.labelBold.copyWith(color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ..._localComments.map((c) => CommentWidget(
                  comment: c,
                  onLike: () async {
                    await widget.onLike(c.id);
                    await _refreshComments();
                  },
                  onEdit: () async {
                    await widget.onEdit(c.id, c.content);
                    await _refreshComments();
                  },
                  onDelete: () async {
                    await widget.onDelete(c.id);
                    await _refreshComments();
                  },
                  currentUserId: widget.currentUserId,
                )),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: TosReviewSpacings.s),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          await widget.onSend(commentController.text);
                          commentController.clear();
                          await _refreshComments();
                        },
                        child: Icon(Icons.send, size: 20, color: TosReviewColors.primary),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Add a comment",
                      isDense: true,
                      hintStyle: TextStyle(color: TosReviewColors.greyDark),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                        borderSide: BorderSide(color: TosReviewColors.greyDark, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                        borderSide: BorderSide(color: TosReviewColors.primary, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                        borderSide: BorderSide(color: TosReviewColors.primary, width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                        borderSide: BorderSide(color: TosReviewColors.primary, width: 2),
                      ),
                    ),
                    style: TosReviewTextStyles.body,
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