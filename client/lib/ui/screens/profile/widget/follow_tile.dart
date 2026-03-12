import 'package:client/ui/screens/profile/user_profile.dart';
import 'package:client/ui/widgets/actions/small_button.dart';
import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class FollowTile extends StatelessWidget {
  final String? image;
  final String name;
  final bool isActive;
  final VoidCallback onAction;
  final bool isMe;
  final String authorId;

  const FollowTile({
    super.key,
    this.image,
    required this.name,
    required this.isActive,
    required this.onAction,
    required this.isMe,
    required this.authorId
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfile(userId: authorId)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
        child: ClipOval(
          child: image != null
            ? Image.network(image!, fit: BoxFit.cover)
            : Image.asset('assets/images/home/product1.png', fit: BoxFit.cover),
        ),
      ),
      title: Text(name, style: TosReviewTextStyles.body),
      trailing: isMe 
      ? null
      : SmallButton(
        onPress: onAction,
        name: isActive ? 'Follow' : 'Followed',
        isActive: isActive,
        width: 120,
      ),
    );
  }
}