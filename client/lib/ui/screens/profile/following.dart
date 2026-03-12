import 'package:client/services/follow_service.dart';
import 'package:client/services/user_service.dart';
import 'package:client/ui/screens/profile/widget/follow_tile.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class Following extends StatefulWidget {
  final String userId;
  const Following({super.key, required this.userId});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  List<Map<String, dynamic>> _following = [];
  Map<String, bool> _followingStatus = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFollowing();
  }

  Future<void> _loadFollowing() async {
    try {
      final following = await followService.getFollowing(widget.userId);
      final Map<String, bool> status = {};
      for (final f in following) {
        final isFollowing = await followService.isFollowing(f['id']);
        status[f['id']] = isFollowing;
      }
      setState(() {
        _following = following;
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
        title: Text("Following", style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary)),
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
                Text("People ${_following.length}", style: TosReviewTextStyles.labelBold),
                const SizedBox(height: TosReviewSpacings.s),
                Expanded(
                  child: ListView.builder(
                    itemCount: _following.length,
                    itemBuilder: (context, index) {
                      final user = _following[index];
                      final isFollowing = _followingStatus[user['id']] ?? false;
                      final isMe = user['id'] == userService.currentUserId;
                      return FollowTile(
                        authorId: user['id'],
                        image: user['image'],
                        name: user['name'],
                        isMe: isMe,
                        isActive: !isFollowing,
                        onAction: isMe ? () {} : () => _toggleFollow(user['id']),
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