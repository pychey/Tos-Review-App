import 'package:client/main.dart';
import 'package:client/services/user_service.dart';
import 'package:client/ui/screens/interest/widget/interest_item.dart';
import 'package:client/ui/widgets/actions/meduim_button.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

List<String> interests = [
  "Food",
  "Skincare",
  "Fashion",
  "Travel",
  "Photography",
  "Music",
  "Movies",
  "Gaming",
  "Technology",
  "Fitness",
  "Sports",
  "Reading",
  "Art",
  "Pets",
  "Nature"
];

class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  final List<String> selectedItems = [];

  void onItem(String item){
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item); 
      } else {
        selectedItems.add(item);      
      }
    });
  }

  void onNext() async {
    if (selectedItems.isEmpty) return;
    await userService.saveInterests(selectedItems);
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AppRoot()),
        (route) => false,
      );
    }
  }

  void onSkip() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AppRoot()),
      (route) => false,
    );
  }

  Color get bgNextButton => selectedItems.isEmpty ? TosReviewColors.gradientLight : TosReviewColors.primary;
  String get textNextButton => selectedItems.isEmpty ? "Next" : "Next (${selectedItems.length})";
  Color get textColorNextButton => selectedItems.isEmpty ? Colors.black : TosReviewColors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TosReviewColors.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Text("Choose what you like", style: TosReviewTextStyles.heading,),
            const SizedBox(height: 10),
            Text("Your feed will be personalised based on \nwhat you like", textAlign: TextAlign.center, style: TosReviewTextStyles.body,),
            const SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: interests.map((i) {
                return InterestItem(
                  itemName: i,
                  onPress: (value) => onItem(value),
                );
              }).toList(),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: MeduimButton(onPress: onSkip, name: "Skip", bgColor: TosReviewColors.greyLight, textColor: Colors.black,)
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: MeduimButton(onPress: onNext, name: textNextButton, bgColor: bgNextButton, textColor: textColorNextButton,)
                )
              ],
            )
      
          ],
        ),
      ),
    );
  }
}

