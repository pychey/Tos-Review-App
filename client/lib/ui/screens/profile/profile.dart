import 'package:client/services/auth_service.dart';
import 'package:client/ui/screens/profile/following.dart';
import 'package:client/ui/screens/register/login.dart';
import 'package:client/ui/widgets/actions/small_button.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../widgets/displays/review_post.dart';
import 'edit_profile.dart';
import 'follower.dart';
enum Filter{
  create,
  saved
}
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Filter selectedfilter = Filter.create;
  int length = 2;

  void onFilter(Filter selectFilter){
    setState(() {
      length = selectFilter == Filter.create ? 2 : 5;
      selectedfilter = selectFilter;
    });
  }

  void onShareProfile() async {
    await authService.logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false,
      );
    }
  }

  void onEditProfile(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfile()),
    );
  }

  void onFollowing(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Following()),
    );
  }

  void onFollower(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Follower()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TosReviewColors.white,
      appBar: AppBar(
        title: Text("Profile", style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary),),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: TosReviewColors.white,
        centerTitle: true,
        actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                child: GestureDetector(
                  onTap: onShareProfile,
                  child: Icon(Icons.ios_share, size: 25,)
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: TosReviewSpacings.s),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: TosReviewColors.primary)
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/home/product1.png', 
                    fit: BoxFit.cover, 
                  ),
                ),
              ),
              const SizedBox(height: TosReviewSpacings.m,),
              Text("Leng Menghan", style: TosReviewTextStyles.titleBold,),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo_image.png', width: 20, height: 20,),
                  const SizedBox(width: 6),
                  Text("mengHan24", style: TosReviewTextStyles.body,),
                ],
              ),
              const SizedBox(height: TosReviewSpacings.m,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onFollowing,
                    child: Text("6 Following", style: TosReviewTextStyles.body,)
                  ),
                  const SizedBox(width: TosReviewSpacings.xxl,),
                  GestureDetector(
                    onTap: onFollower,
                    child: Text("6 Follower", style: TosReviewTextStyles.body,)
                  ),
                ],
              ),
              const SizedBox(height: TosReviewSpacings.l,),
              SmallButton(
                onPress: onEditProfile, 
                name: "Edit Profile",
                width: 150,
                icon: Icons.edit,
                isActive: true,
              ),
              const SizedBox(height: TosReviewSpacings.l,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: Filter.values.map((f)=>
                  GestureDetector(
                    onTap: () => onFilter(f),
                    child: Text(
                      f.name, 
                      style: TosReviewTextStyles.label.copyWith(
                        color: selectedfilter == f ? TosReviewColors.primary : Colors.black,
                        fontWeight:  selectedfilter == f ? FontWeight.bold : FontWeight.normal
                      )
                    )
                  ),
                ).toList(),
              ),
              const SizedBox(height: TosReviewSpacings.m,),
              GridView.builder(
                itemCount: length,
                shrinkWrap: true, 
                physics: const NeverScrollableScrollPhysics(), 
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.7, 
                ),
                itemBuilder: (context, index) {
                  return ReviewPost(onPress: (){},);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}