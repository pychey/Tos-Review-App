import 'package:client/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool islength;
  final TextEditingController text;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isRequired;
  const CustomTextField ({super.key, required this.label, required this.hintText, required this.text, this.islength = false, required this.validator, this.isPassword = false, required this.isRequired});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _notShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TosReviewTextStyles.label.copyWith(color: Colors.black, fontFamily: 'Montserrat'),
            children: [
              TextSpan(text: widget.label, ),
              if(widget.isRequired)TextSpan(
                text: " *",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(height: 7),
        TextFormField(
          obscureText: widget.isPassword ? _notShowPassword : false,
          validator: widget.validator,
          controller: widget.text,
          maxLength: widget.islength ? 50 : null,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword ? IconButton(
              icon: Icon(
                _notShowPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _notShowPassword = !_notShowPassword;
                });
              },
            ) : null,
            prefixStyle: TextStyle(color: Colors.black),
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
            isDense: true,
            hintStyle: TextStyle(color: TosReviewColors.greyDark),
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
      ],
    );
  }
}
