import 'package:client/data/models/post.dart';
import 'package:client/services/post_service.dart';
import 'package:client/ui/screens/inspect_post/inspect_post.dart';
import 'package:client/ui/widgets/displays/review_post.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class ViewHistory extends StatefulWidget {
  const ViewHistory({super.key});

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final posts = await postService.getViewHistory();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TosReviewColors.white,
      appBar: AppBar(
        title: Text('History', style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary)),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: TosReviewColors.white,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _posts.isEmpty
              ? Center(
                  child: Text('No history yet', style: TosReviewTextStyles.body.copyWith(color: Colors.grey)),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
                  itemCount: _posts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return ReviewPost(
                      onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InspectPost(postId: post.id)),
                      ),
                      post: post,
                    );
                  },
                ),
    );
  }
}