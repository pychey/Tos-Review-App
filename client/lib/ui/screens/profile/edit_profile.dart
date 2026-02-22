import 'package:client/ui/widgets/actions/small_button.dart';
import 'package:client/ui/widgets/inputs/text_field.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState(){
    super.initState();
    fullNameController.text = "Leng Menghan";
    nickNameController.text = "mengHan24";
    phoneNumberController.text = "012 345 678";
  }

  void onChange(){

  }

  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    if (value.length > 15) {
      return "Can not more than 15 characters";
    }
    return null;
  }

  String? validateNickName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Nickname is required";
    }
    if (value.length > 15) {
      return "Can not more than 15 characters";
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    return null;
  }
  @override
  void dispose() {
    fullNameController.dispose(); 
    nickNameController.dispose(); 
    phoneNumberController.dispose(); 
    super.dispose();      
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit Profile", style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary),),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: TosReviewColors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "keep your personal detail private.\ninformation you add herer is visible to\n anyone who can view your profile", 
                style: TosReviewTextStyles.small,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TosReviewSpacings.xxl),
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
              const SizedBox(height: TosReviewSpacings.m),
              Text("Photo", style: TosReviewTextStyles.button.copyWith(color: TosReviewColors.primary),),
              const SizedBox(height: TosReviewSpacings.m),
              SmallButton(onPress: onChange, name: "Change", isActive: true,),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Full name", hintText: "", text: fullNameController, validator: validateFullName, isRequired: false),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Nick name", hintText: "", text: nickNameController, validator: validateFullName, isRequired: false),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Phone number", hintText: "", text: phoneNumberController, validator: validateFullName, isRequired: false),
        
            ],
          ),
        ),
      ),
    );
  }
}