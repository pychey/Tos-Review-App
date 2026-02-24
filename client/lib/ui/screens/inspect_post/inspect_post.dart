import 'package:client/ui/screens/inspect_post/comment_view.dart';
import 'package:client/ui/screens/inspect_post/widget/post_image.dart';
import 'package:client/ui/widgets/displays/review_post.dart';
import 'package:flutter/material.dart';

import '../../../utils/animations_util.dart';
import '../../theme/theme.dart';
import '../../widgets/actions/small_button.dart';
import '../../widgets/displays/comment.dart';
import 'widget/rating.dart';

class InspectPost extends StatefulWidget {
  const InspectPost({super.key});

  @override
  State<InspectPost> createState() => _InspectPostState();
}

class _InspectPostState extends State<InspectPost> {
  void onSeeMore(){
    Navigator.push(
      context,
      AnimationUtils.slideBTHalfScreen(
        CommentView()
      )
    );
  }

  void onPressPost(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InspectPost()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: TosReviewSpacings.paddingScreen, vertical: TosReviewSpacings.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back)
                ),
                const SizedBox(height: TosReviewSpacings.l),
                PostImage(),
                const SizedBox(height: TosReviewSpacings.m),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Rating(onClick: (value){}),
                    Row(
                      children: [
                        // Text("123", style: TosReviewTextStyles.small,),
                        // const SizedBox(width: 10),
                        Icon(Icons.favorite),
                        const SizedBox(width: 10),
                        SmallButton(onPress: (){}, name: "Save", isActive: true, width: 70,)
          
                      ],
                    )
                  ],
                ),
                const SizedBox(height: TosReviewSpacings.s),
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/home/product1.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Text("Leng Menghan", style: TosReviewTextStyles.labelBold.copyWith(fontWeight: FontWeight.bold, color: TosReviewColors.greyDark),),
                    ),
                  ],
                ),
                const SizedBox(height: TosReviewSpacings.s),
                Text("Green Ovlie Oil", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
                Text("I love the texture it is verygood and make my hair look shine", style: TosReviewTextStyles.body),
                Text("Price : 32\$ i buy it from zando.", style: TosReviewTextStyles.body),
                const SizedBox(height: TosReviewSpacings.s,),
                Divider(),
                const SizedBox(height: TosReviewSpacings.s,),
                Row(
                  children: [
                    Text("2 comments", style: TosReviewTextStyles.body.copyWith(fontWeight: FontWeight.bold),),
                    Spacer(),
                    GestureDetector(
                      onTap: onSeeMore,
                      child: Text("see more", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark, decoration: TextDecoration.underline))),
                  ],
                ),
                const SizedBox(height: TosReviewSpacings.s,),
                Comment(),
                Comment(),
                const SizedBox(height: TosReviewSpacings.s,),
                // Divider(),
                // const SizedBox(height: TosReviewSpacings.s,),
                Text("Related Product", style: TosReviewTextStyles.labelBold.copyWith(color: TosReviewColors.primary),),
                GridView.builder(
                  itemCount: 10,
                  shrinkWrap: true, // VERY IMPORTANT
                  physics: const NeverScrollableScrollPhysics(), 
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.7, 
                  ),
                  itemBuilder: (context, index) {
                    return ReviewPost(onPress: onPressPost,);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}