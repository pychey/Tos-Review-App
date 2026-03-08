import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../inspect_post/inspect_post.dart';
import 'widget/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void onNotification(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InspectPost()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TosReviewColors.white,
      appBar: AppBar(
        title: Text("New", style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary),),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: TosReviewColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationTile(imagePath: "assets/images/home/product1.png", title: 'Handmade pieces that took time to make', date: "03 Aug 2022", duration: '15h', onPress: onNotification,),
              NotificationTile(imagePath: "assets/images/home/product1.png", title: 'Handmade pieces that took time to make', date: "03 Aug 2022", duration: '15h', onPress: onNotification),
              NotificationTile(imagePath: "assets/images/home/product1.png", title: 'Handmade pieces that took time to make', date: "03 Aug 2022", duration: '15h', onPress: onNotification),
              NotificationTile(imagePath: "assets/images/home/product1.png", title: 'Handmade pieces that took time to make', date: "03 Aug 2022", duration: '15h', onPress: onNotification),
              NotificationTile(imagePath: "assets/images/home/product1.png", title: 'Handmade pieces that took time to make', date: "03 Aug 2022", duration: '15h', onPress: onNotification),
              NotificationTile(imagePath: "assets/images/home/product1.png", title: 'Handmade pieces that took time to make', date: "03 Aug 2022", duration: '15h', onPress: onNotification),
              NotificationTile(imagePath: "assets/images/home/product1.png", title: 'Handmade pieces that took time to make', date: "03 Aug 2022", duration: '15h', onPress: onNotification),
              NotificationTile(imagePath: "assets/images/home/product1.png", title: 'Handmade pieces that took time to make', date: "03 Aug 2022", duration: '15h', onPress: onNotification),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

