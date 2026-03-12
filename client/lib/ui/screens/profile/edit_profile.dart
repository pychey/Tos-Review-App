import 'package:client/services/post_service.dart';
import 'package:client/services/user_service.dart';
import 'package:client/ui/screens/profile/widget/button_delete_profile.dart';
import 'package:client/ui/widgets/actions/small_button.dart';
import 'package:client/ui/widgets/inputs/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../theme/theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController websiteUrlController = TextEditingController();
  File? imageFile;
  String? _existingProfileSrc;

  @override
  void initState() {
    super.initState();
    final user = userService.cachedUser;
    if (user != null) {
      nameController.text = user.name;
      bioController.text = user.bio ?? '';
      websiteUrlController.text = user.websiteUrl ?? '';
      _existingProfileSrc = user.profileSrc;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = File(image.path); 
      });
    }
  }

  void deleteProfile(){
    setState(() {
      imageFile = null;
    });
  }

  void onChange() async {
    try {
      String? profileSrc = _existingProfileSrc;
      if (imageFile != null) {
        profileSrc = await postService.uploadFile(XFile(imageFile!.path));
      }
      await userService.updateProfile(
        name: nameController.text,
        bio: bioController.text.isNotEmpty ? bioController.text : null,
        websiteUrl: websiteUrlController.text.isNotEmpty ? websiteUrlController.text : null,
        profileSrc: profileSrc,
      );
      if (mounted) Navigator.pop(context);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Something went wrong';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    }
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
    nameController.dispose();
    bioController.dispose();
    websiteUrlController.dispose();
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
              Stack(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: TosReviewColors.primary,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: imageFile != null
                          ? Image.file(imageFile!, fit: BoxFit.cover)
                          : _existingProfileSrc != null
                            ? Image.network(_existingProfileSrc!, fit: BoxFit.cover)
                            : Container(
                                color: Colors.grey[300],
                                child: Center(child: Icon(Icons.add, size: 40, color: Colors.black54)),
                              ),
                      ),
                    ),
                  ),
                  if (imageFile != null) Positioned(
                      right: 10,
                      bottom: 10,
                      child: ButtonDeleteProfile(onPress: deleteProfile),
                    ),
                ],
              ),
              const SizedBox(height: TosReviewSpacings.m),
              Text("Photo", style: TosReviewTextStyles.button.copyWith(color: TosReviewColors.primary),),
              const SizedBox(height: TosReviewSpacings.m),
              SmallButton(onPress: onChange, name: "Change", isActive: true,),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Full name", hintText: "", text: nameController, validator: validateFullName, isRequired: true),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Bio", hintText: "Tell us about yourself", text: bioController, validator: null, isRequired: false),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Website URL", hintText: "https://...", text: websiteUrlController, validator: null, isRequired: false),
            ],
          ),
        ),
      ),
    );
  }
}