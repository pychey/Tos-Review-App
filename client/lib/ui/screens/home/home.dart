import 'package:client/data/models/post.dart';
import 'package:client/services/post_service.dart';
import 'package:client/ui/screens/inspect_post/inspect_post.dart';
import 'package:client/ui/screens/search/search.dart';
import 'package:client/ui/widgets/displays/review_post.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> _posts = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadFeed();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !_isLoadingMore &&
          _hasMore) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadFeed() async {
    try {
      final posts = await postService.getFeed(page: 1, limit: 10);
      setState(() {
        _posts = posts;
        _page = 1;
        _hasMore = posts.length == 10;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    try {
      final nextPage = _page + 1;
      final posts = await postService.getFeed(page: nextPage, limit: 10);
      setState(() {
        _posts.addAll(posts);
        _page = nextPage;
        _hasMore = posts.length == 10;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() => _isLoadingMore = false);
    }
  }

  void onPressPost(String postId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InspectPost(postId: postId)),
    );
    _loadFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: TosReviewColors.primary))
          : SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("All", style: TosReviewTextStyles.labelBold.copyWith(color: TosReviewColors.primary)),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Search()),
                              ),
                              child: Icon(Icons.search, size: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ReviewPost(
                            onPress: () => onPressPost(_posts[index].id),
                            post: _posts[index],
                          );
                        },
                        childCount: _posts.length,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                    ),
                  ),
                  if (_isLoadingMore)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(child: CircularProgressIndicator(color: TosReviewColors.primary)),
                      ),
                    ),
                  if (!_hasMore && _posts.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text("No more posts", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}