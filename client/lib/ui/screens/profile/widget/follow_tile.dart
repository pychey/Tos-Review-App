import 'package:client/ui/widgets/actions/small_button.dart';
import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class FollowTile extends StatefulWidget {
  final ValueChanged<bool> onAction;
  final String image;
  final String name;
  final String activebuttonName;
  final String inActivebuttonName;
  const FollowTile({super.key, required this.onAction, required this.image, required this.name, required this.activebuttonName, required this.inActivebuttonName});

  @override
  State<FollowTile> createState() => _FollowTileState();
}

class _FollowTileState extends State<FollowTile> {
  bool isActive = false;
  late String buttonName;

  @override
  void initState(){
    buttonName = isActive ? widget.activebuttonName : widget.inActivebuttonName;
    super.initState();
  }

  void onPressButton(){
    widget.onAction(isActive);
    setState(() {
      isActive = !isActive;
      buttonName = isActive ? widget.activebuttonName : widget.inActivebuttonName;
    });
    
  }

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
        child: ClipOval(
          child: Image.asset(
            widget.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(widget.name, style: TosReviewTextStyles.body,),
      trailing: SmallButton(onPress: onPressButton, name: buttonName, isActive: isActive, width: 120),
    );
  }
}