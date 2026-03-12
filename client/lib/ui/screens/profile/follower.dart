import 'package:client/services/follow_service.dart';
import 'package:client/services/user_service.dart';
import 'package:client/ui/screens/profile/widget/follow_tile.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class Follower extends StatefulWidget {
  final String userId;
  const Follower({super.key, required this.userId});

  @override
  State<Follower> createState() => _FollowerState();
}

class _FollowerState extends State<Follower> {
  List<Map<String, dynamic>> _followers = [];
  Map<String, bool> _followingStatus = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFollowers();
  }

  Future<void> _loadFollowers() async {
    try {
      final followers = await followService.getFollowers(widget.userId);
      final Map<String, bool> status = {};
      for (final f in followers) {
        final isFollowing = await followService.isFollowing(f['id']);
        status[f['id']] = isFollowing;
      }
      setState(() {
        _followers = followers;
        _followingStatus = status;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleFollow(String userId) async {
    final result = await followService.followUser(userId);
    setState(() => _followingStatus[userId] = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Follower", style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary)),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: TosReviewColors.white,
        centerTitle: true,
      ),
      body: _isLoading
        ? Center(child: CircularProgressIndicator(color: TosReviewColors.primary))
        : Padding(
            padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("People ${_followers.length}", style: TosReviewTextStyles.labelBold),
                const SizedBox(height: TosReviewSpacings.s),
                Expanded(
                  child: ListView.builder(
                    itemCount: _followers.length,
                    itemBuilder: (context, index) {
                      final follower = _followers[index];
                      final isFollowing = _followingStatus[follower['id']] ?? false;
                      final isMe = follower['id'] == userService.currentUserId;
                      return FollowTile(
                        authorId: follower['id'],
                        image: follower['image'],
                        name: follower['name'],
                        isActive: !isFollowing,
                        isMe: isMe,
                        onAction: isMe ? () {} : () => _toggleFollow(follower['id']),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}