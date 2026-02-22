import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/home/product1.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Text("Leng Menghan", style: TosReviewTextStyles.body.copyWith(fontWeight: FontWeight.bold, color: TosReviewColors.greyDark),),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 50),
              Expanded(
                child: Text(
                  "I love the texture it is verygood and make my hair look", 
                  style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)
                ),
              ),
            ],
          ),
          const SizedBox(height: TosReviewSpacings.s,),
          Row(
            children: [
              const SizedBox(width: 50),
              Text("10 mn", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
              const SizedBox(width: 10),
              Text("Reply", style: TosReviewTextStyles.body),
              const SizedBox(width: 10),
              Icon(Icons.favorite, color: TosReviewColors.greyDark, size: 20,),
              const SizedBox(width: 10),     
              Icon(Icons.more_horiz, size: 20)  
            ],
          )
        ],
      ),
    );
  }
}