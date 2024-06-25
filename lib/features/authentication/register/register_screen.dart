// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_theme/theme_provider.dart';
import 'package:todo_app/config/auth_provider/auth_providers.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/features/authentication/customized_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/features/authentication/login/login_screen.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/fireStore_utils.dart';
import 'package:todo_app/model/my_user.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController firstNameController =
      TextEditingController();

  TextEditingController lastNameController =
      TextEditingController();

  TextEditingController emailController =
      TextEditingController();

  TextEditingController passwordController =
      TextEditingController();

  TextEditingController confirmPasswordController =
      TextEditingController();
  bool showObscurePass = true;
  bool showObscureConfirm = true;
  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: themeProvider.appTheme == ThemeMode.dark
            ? const IconThemeData(color: Colors.white)
            : const IconThemeData(color: Colors.black),
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? const Color(0xFFF6F6F6)
            : const Color(0xFF2A2A2A),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.create_account,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            themeProvider.appTheme == ThemeMode.light
                ? 'assets/images/register_background.png'
                : 'assets/images/register_background_dark.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.none,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        AppLocalizations.of(context)!.sign_up_here,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomizedTextFormField(
                        keyboardType: TextInputType.text,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter First Name';
                          }
                          return null;
                        },
                        validationText:
                            AppLocalizations.of(context)!.first_name,
                        controller: firstNameController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomizedTextFormField(
                        keyboardType: TextInputType.text,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter Last Name';
                          }
                          return null;
                        },
                        validationText: AppLocalizations.of(context)!.last_Name,
                        controller: lastNameController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomizedTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter Email';
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                        validationText: AppLocalizations.of(context)!.email,
                        controller: emailController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomizedTextFormField(
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (showObscurePass == true) {
                              showObscurePass = false;
                            } else {
                              showObscurePass = true;
                            }
                            setState(() {});
                          },
                          icon: const Icon(Icons.remove_red_eye_rounded),
                        ),
                        obscure: showObscurePass,
                        keyboardType: TextInputType.number,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          if (text.length < 8) {
                            return 'Password should be at least 8 characters';
                          }
                          return null;
                        },
                        validationText: AppLocalizations.of(context)!.password,
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomizedTextFormField(
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (showObscureConfirm == true) {
                              showObscureConfirm = false;
                            } else {
                              showObscureConfirm = true;
                            }
                            setState(() {});
                          },
                          icon: const Icon(Icons.remove_red_eye_rounded),
                        ),
                        obscure: showObscureConfirm,
                        keyboardType: TextInputType.number,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter confirm password';
                          }
                          if (text != passwordController.text) {
                            return "Confirm Password doesn't match password";
                          }
                          return null;
                        },
                        validationText:
                            AppLocalizations.of(context)!.confirm_password,
                        controller: confirmPasswordController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.blueColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 10),
                          onPressed: () {
                            confirmValidationTab();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.sign_up_here,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .existing_account_quote,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context, LoginScreen.routeName);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.login_here,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: MyTheme.blueColor),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  confirmValidationTab() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        FireBaseUtils.readUserFromFireStore(credential.user?.uid ?? '');
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text);
        await FireBaseUtils.addUserToFireStore(myUser);
        var authProviders = Provider.of<AuthProviders>(context, listen: false);
        authProviders.changeUser(myUser);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            contentMsg: AppLocalizations.of(context)!.register_success,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
            isDismissible: false,
            titleMsg: AppLocalizations.of(context)!.success);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            contentMsg: AppLocalizations.of(context)!.password_is_weak,
            titleMsg: AppLocalizations.of(context)!.alert,
            isDismissible: false,
            posActionName: AppLocalizations.of(context)!.ok,
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            contentMsg: AppLocalizations.of(context)!.account_already_exist,
            titleMsg: AppLocalizations.of(context)!.alert,
            isDismissible: false,
            posActionName: AppLocalizations.of(context)!.ok,
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          contentMsg: e.toString(),
          titleMsg: AppLocalizations.of(context)!.alert,
          isDismissible: false,
          posActionName: AppLocalizations.of(context)!.ok,
        );
      }
    }
  }
}
