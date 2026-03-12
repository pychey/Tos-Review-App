import 'package:client/services/post_service.dart';
import 'package:client/ui/theme/theme.dart';
import 'package:client/ui/screens/create_post/widget/choose_image_button.dart';
import 'package:client/ui/widgets/actions/small_button.dart';
import 'package:client/ui/screens/create_post/widget/create_post_img_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/inputs/text_field.dart';
import '../inspect_post/widget/rating.dart';
import 'dart:io';
class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String selectedCategory = "FOOD";
  bool isAnonymous = true;
  double _authorRating = 0;

  final ImagePicker picker = ImagePicker();
  List<XFile> images = [];

  Future<void> pickImages() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        images.addAll(selectedImages); // ← adds new images to the list
      });
    }
  }

  void updateImage(int index) async {
    final XFile? newImage = await picker.pickImage(source: ImageSource.gallery);
    if (newImage != null) {
      setState(() {
        images[index] = newImage;
      });
    }
  }

  void removeImage(int index){
    setState(() {
      images.removeAt(index);
    });
  }

  String? validateProductName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Product name is required";
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Description is required";
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Price is required";
    }
    return null;
  }

  String? validateLoaction(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Location is required";
    }
    return null;
  }

  void onCreate() async {
    if (_authorRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a rating')),
      );
      return;
    }

    try {
      List<String> mediaUrls = [];
      for (final image in images) {
        final url = await postService.uploadFile(image);
        mediaUrls.add(url);
      }

      await postService.createPost(
        productName: productNameController.text,
        description: descriptionController.text,
        authorRating: _authorRating,
        category: selectedCategory,
        isAnonymous: isAnonymous,
        price: priceController.text.isNotEmpty ? double.tryParse(priceController.text) : null,
        location: locationController.text,
        mediaUrls: mediaUrls,
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Something went wrong';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  @override
  void dispose(){
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TosReviewColors.white,
      appBar: AppBar(
        title: Text("Create Post", style: TosReviewTextStyles.titleBold.copyWith(color: TosReviewColors.primary),),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: TosReviewColors.white,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TosReviewSpacings.paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: images.isEmpty ? 
                  ChooseImageButton(onPress: pickImages)
                : SizedBox(
                    height: 200, 
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length + 1, 
                      itemBuilder: (context, index) {
                        if (index == images.length) return ChooseImageButton(onPress: pickImages);
                        return CreatePostImgPreview(image: images[index], onEdit:() => updateImage(index), onDelete: () => removeImage(index));
                      },
                    ),
                  )
              ),
              const SizedBox(height: TosReviewSpacings.xxl),
              CustomTextField(label: "Product Name", hintText: "Enter the product name", text: productNameController, validator: validateProductName, isRequired: true),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Description", hintText: "Enter the description", text: descriptionController, validator: validateDescription, isRequired: true),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Price", hintText: "Enter the price", text: priceController, validator: validatePrice, isRequired: true),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Location", hintText: "Enter the location", text: locationController, validator: validateLoaction, isRequired: true),
              const SizedBox(height: TosReviewSpacings.m),
              RichText(
                text: TextSpan(
                  style: TosReviewTextStyles.label.copyWith(color: Colors.black, fontFamily: 'Montserrat'),
                  children: [
                    TextSpan(text: "Category"),
                    TextSpan(
                      text: " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),
              DropdownButtonFormField(
                initialValue: selectedCategory,
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
                // validator: validator,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 13, 0, 13),
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
                style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark,fontSize: 16, fontFamily: 'Montserrat'),
                items: [
                  DropdownMenuItem<String>(
                    value: "FOOD", 
                    child: Text("Food", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark),)
                  ),
                  DropdownMenuItem<String>(
                    value: "BEAUTY", 
                    child: Text("Beauty", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark),)
                  ),
                  DropdownMenuItem<String>(
                    value: "OTHER", 
                    child: Text("Other", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark),)
                  )
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCategory = value;
                    });
                  }
                },
                selectedItemBuilder: (BuildContext context) {
                  return [
                    Text("Food", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
                    Text("Skincare", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
                    Text("Other", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
                  ];
                },
              ),
              const SizedBox(height: TosReviewSpacings.m),
              Rating(
                onClick: (value) {
                  setState(() {
                    _authorRating = value.toDouble();
                  });
                },
              ),
              const SizedBox(height: TosReviewSpacings.m),
              Row(
                children: [
                  Switch(
                    activeTrackColor: Colors.green, // track when ON
                    inactiveThumbColor: Colors.white, // thumb when OFF
                    inactiveTrackColor: Colors.grey, 
                    value: isAnonymous,
                    onChanged: (value) {
                      setState(() {
                        isAnonymous = value;
                      });
                    },
                  ),
                  const SizedBox(width: 15),
                  Text("Anonymous", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
                  const Spacer(),
                  SmallButton(onPress: onCreate, name: "Create", isActive: true)
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}