import 'package:client/ui/theme/theme.dart';
import 'package:client/ui/widgets/actions/button.dart';
import 'package:client/ui/widgets/actions/small_button.dart';
import 'package:client/ui/widgets/displays/comment.dart';
import 'package:flutter/material.dart';

import '../../widgets/inputs/text_field.dart';
import '../inspect_post/widget/rating.dart';

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
  String selectedCategory = "Food";
  bool isAnonymous = true;

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

  void onCreate(){

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
                child: ClipRRect(
                   borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                  child: Image.asset(
                    'assets/images/home/product1.png', 
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200, 
                  ),
                ),
              ),
              const SizedBox(height: TosReviewSpacings.xxl),
              CustomTextField(label: "Product Name", hintText: "Enter the product name", text: productNameController, validator: validateProductName, isRequired: true),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Description", hintText: "Enter the description", text: productNameController, validator: validateDescription, isRequired: true),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Price", hintText: "Enter the price", text: productNameController, validator: validatePrice, isRequired: true),
              const SizedBox(height: TosReviewSpacings.m),
              CustomTextField(label: "Location", hintText: "Enter the location", text: productNameController, validator: validateLoaction, isRequired: true),
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
                    value: "Food", 
                    child: Text("Food", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark),)
                  ),
                  DropdownMenuItem<String>(
                    value: "Skincare", 
                    child: Text("Skincare", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark),)
                  ),
                  DropdownMenuItem<String>(
                    value: "Clothing", 
                    child: Text("Clothing", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark),)
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
                    Text("Clothing", style: TosReviewTextStyles.body.copyWith(color: TosReviewColors.greyDark)),
                  ];
                },
              ),
              const SizedBox(height: TosReviewSpacings.m),
              Rating(onClick: (value){}),
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