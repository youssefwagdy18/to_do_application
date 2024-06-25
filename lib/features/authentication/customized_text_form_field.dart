// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_theme/theme_provider.dart';
import 'package:todo_app/config/my_theme.dart';

typedef ValidatorFunction = String? Function(String?)?;
class CustomizedTextFormField extends StatelessWidget {

  ValidatorFunction validator;
  TextInputType keyboardType;
  String validationText;
  TextEditingController controller;
  bool obscure;
  IconButton? suffixIcon;
  CustomizedTextFormField(
      {super.key,
        required this.keyboardType,
      required this.validationText,
      required this.controller,
      required this.validator,
        this.suffixIcon,
      this.obscure=false});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return TextFormField(
      obscureText: obscure,
      keyboardType: keyboardType,
      style: TextStyle(color:themeProvider.appTheme == ThemeMode.dark? Colors.white:
      Colors.black),
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.0),
          ),
          fillColor: themeProvider.appTheme==ThemeMode.light?Colors.white:
          MyTheme.darkGreyColor,
          filled: true,
          errorBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(25.0),),
          label: Text(
            validationText,
            style: themeProvider.appTheme==ThemeMode.light?Theme.of(context).textTheme.bodyMedium:
            Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
          )),
    );
  }
}
