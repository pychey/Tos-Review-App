import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'widget/follow_tile.dart';

class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  void onAction(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Following", style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary),),
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
                      buttonName: "unFollow",
                      isActive: false,
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