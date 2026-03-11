import 'package:client/ui/screens/inspect_post/inspect_post.dart';
import 'package:client/ui/widgets/displays/review_post.dart';
import 'package:client/ui/widgets/inputs/text_field.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void onPressPost(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InspectPost(postId: '',)),
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
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, size: 30,),
                    fillColor: const Color.fromARGB(255, 232, 223, 223),
                    filled: true,
                    hintText: "Search",
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                      borderSide: BorderSide(color: TosReviewColors.greyDark, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                      borderSide: BorderSide(color: TosReviewColors.primary, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                      borderSide: BorderSide(color: TosReviewColors.primary, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                      borderSide: BorderSide(color: TosReviewColors.primary, width: 2),
                    ),
                  ),
                  style: TosReviewTextStyles.body,
                ),
              ),
              const SizedBox(height: TosReviewSpacings.l,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10),
                color: TosReviewColors.primary,
                child: Text("Best Rating for you",textAlign: TextAlign.center, style: TosReviewTextStyles.body.copyWith(color: Colors.white),),
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
                  childAspectRatio: 1, 
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                        child: Image.asset(
                          "assets/images/home/product1.png",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.5),
                          colorBlendMode: BlendMode.darken, 
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Center(
                          child: Text("Luxuray Bag", style: TosReviewTextStyles.labelBold.copyWith(color: TosReviewColors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
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