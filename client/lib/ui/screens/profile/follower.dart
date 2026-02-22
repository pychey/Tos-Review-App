import 'package:client/ui/screens/profile/widget/follow_tile.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class Follower extends StatefulWidget {
  const Follower({super.key});

  @override
  State<Follower> createState() => _FollowerState();
}

class _FollowerState extends State<Follower> {
  void onAction(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Follower", style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary),),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: TosReviewColors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("People 6", style: TosReviewTextStyles.labelBold),
            const SizedBox(height: TosReviewSpacings.s,),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: 20,
                  shrinkWrap: true, 
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return FollowTile(
                      onAction: onAction, 
                      image: 'assets/images/home/product1.png', 
                      name: "Leng Menghan", 
                      buttonName: "Follow back",
                      isActive: true,
                    );
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}