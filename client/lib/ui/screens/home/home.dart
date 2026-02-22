import 'package:client/ui/screens/inspect_post/inspect_post.dart';
import 'package:client/ui/widgets/displays/review_post.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void onPressPost(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InspectPost()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All", style: TosReviewTextStyles.labelBold.copyWith(color: TosReviewColors.primary),),
                    Icon(Icons.search, size: 30,)
                  ],
                ),
              ),
              const SizedBox(height: TosReviewSpacings.l,),
              GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                shrinkWrap: true,
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
    );
  }
}