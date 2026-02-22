import 'package:client/ui/theme/theme.dart';
import 'package:client/ui/widgets/displays/comment.dart';
import 'package:flutter/material.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key});

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final TextEditingController commentController = TextEditingController();

  void onSend(){

  }

  void onAddSticker(){

  }

  @override
  void dispose(){
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)
                  ),
                  color: TosReviewColors.primary
                ),
                child: Text("2 comments", style: TosReviewTextStyles.labelBold.copyWith(color: Colors.white),),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Comment(),
                    Comment(),
                    Comment(),
                    Comment(),
                    Comment(),
                    Comment(),
                  ],
                )
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onAddSticker,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: TosReviewColors.primary,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Icon(Icons.add, size: 20, color: Colors.white, fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                    const SizedBox(width: TosReviewSpacings.s,),
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: onSend,
                            child: Icon(Icons.send, size: 20, color: TosReviewColors.primary,),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Add a comment",
                          isDense: true,
                          hintStyle: TextStyle(color: TosReviewColors.greyDark),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                  ],
                ),
              ),
            ],
          ),
    );
  
  }
}