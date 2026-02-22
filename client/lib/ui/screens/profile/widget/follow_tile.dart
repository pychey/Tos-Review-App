import 'package:client/ui/widgets/actions/small_button.dart';
import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class FollowTile extends StatefulWidget {
  final VoidCallback onAction;
  final String image;
  final String name;
  final String buttonName;
  final bool isActive;
  const FollowTile({super.key, required this.onAction, required this.image, required this.name, required this.buttonName, required this.isActive});

  @override
  State<FollowTile> createState() => _FollowTileState();
}

class _FollowTileState extends State<FollowTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber
        ),
        // child: Center(child: Text("H")),
        child: ClipOval(
          child: Image.asset(
            widget.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(widget.name, style: TosReviewTextStyles.body,),
      // trailing: GestureDetector(
      //   onTap: widget.onAction,
      //   child: Container(
      //     width: 100,
      //     padding: EdgeInsets.symmetric(horizontal: 0, vertical: 7),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(10),
      //       color: TosReviewColors.primary
      //     ),
      //     child: Text("That's you", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.white), textAlign: TextAlign.center,),
      //   ),
      // ),
      trailing: SmallButton(onPress: widget.onAction, name: widget.buttonName, isActive: widget.isActive, width: 120),
    );
  }
}