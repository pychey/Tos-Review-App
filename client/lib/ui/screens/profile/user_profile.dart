import 'package:client/data/models/api_user.dart';
import 'package:client/data/models/post.dart';
import 'package:client/services/follow_service.dart';
import 'package:client/services/post_service.dart';
import 'package:client/services/user_service.dart';
import 'package:client/ui/screens/inspect_post/inspect_post.dart';
import 'package:client/ui/screens/profile/follower.dart';
import 'package:client/ui/screens/profile/following.dart';
import 'package:client/ui/widgets/actions/small_button.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../widgets/displays/review_post.dart';

class UserProfile extends StatefulWidget {
  final String userId;
  const UserProfile({super.key, required this.userId});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ApiUser? _user;
  List<Post> _posts = [];
  bool _isLoading = true;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final user = await userService.getUserProfile(widget.userId);
      final posts = await postService.getMyPosts(widget.userId);
      final followStatus = await followService.isFollowing(widget.userId);
      setState(() {
        _user = user;
        _posts = posts;
        _isFollowing = followStatus;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleFollow() async {
    final result = await followService.followUser(widget.userId);
    setState(() => _isFollowing = result);
    _loadProfile();
  }

  void onFollowing() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Following(userId: widget.userId)),
    );
  }

  void onFollower() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Follower(userId: widget.userId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TosReviewColors.white,
      appBar: AppBar(
        title: Text(_user?.name ?? '', style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary)),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: TosReviewColors.white,
        centerTitle: true,
      ),
      body: _isLoading
        ? Center(child: CircularProgressIndicator(color: TosReviewColors.primary))
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: TosReviewSpacings.s),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: TosReviewColors.primary),
                    ),
                    child: ClipOval(
                      child: _user?.profileSrc != null
                        ? Image.network(_user!.profileSrc!, fit: BoxFit.cover)
                        : Image.asset('assets/images/home/product1.png', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: TosReviewSpacings.m),
                  Text(_user?.name ?? '', style: TosReviewTextStyles.titleBold),
                  const SizedBox(height: 5),
                  if (_user?.bio != null && _user!.bio!.isNotEmpty)
                    Text(_user!.bio!, style: TosReviewTextStyles.body, textAlign: TextAlign.center),
                  const SizedBox(height: TosReviewSpacings.m),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: onFollowing,
                        child: Text("${_user?.count.followers ?? 0} Following", style: TosReviewTextStyles.body,)
                      ),
                      const SizedBox(width: TosReviewSpacings.xxl,),
                      GestureDetector(
                        onTap: onFollower,
                        child: Text("${_user?.count.following ?? 0} Follower", style: TosReviewTextStyles.body,)
                      ),
                    ],
                  ),
                  const SizedBox(height: TosReviewSpacings.l),
                  SmallButton(
                    onPress: _toggleFollow,
                    name: _isFollowing ? "Unfollow" : "Follow",
                    width: 150,
                    isActive: !_isFollowing,
                  ),
                  const SizedBox(height: TosReviewSpacings.l),
                  const SizedBox(height: TosReviewSpacings.m),
                  GridView.builder(
                    itemCount: _posts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                        showAuthorInfo: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}