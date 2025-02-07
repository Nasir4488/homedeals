import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/utils/colors.dart';
import 'package:homedeals/utils/routes.dart';
import '../../cores/authController/signupControoler.dart';
import '../../utils/textTheams.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  var authController=Get.put(SignUpController());
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Get.toNamed(AllRoutes.homePage);
      }
    });
  }
  @override

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            height: 500,
            width: 500,
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: greyColor.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: authController.nameController,
                  cursorColor: Colors.black,
                  style: textfieldtext,
                  decoration: textFieldDecoration(
                    context: context,
                    hint: "Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: authController.emailController,
                  cursorColor: Colors.black,
                  style: textfieldtext,
                  decoration: textFieldDecoration(
                    context: context,
                    hint: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: authController.passwordController,
                  cursorColor: Colors.black,
                  style: textfieldtext,
                  obscureText: true,
                  decoration: textFieldDecoration(
                    context: context,
                    hint: "Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: authController.confirmPasswordController,
                  cursorColor: Colors.black,
                  style: textfieldtext,
                  obscureText: true,
                  decoration: textFieldDecoration(
                    context: context,
                    hint: "Confirm Password",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != authController.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Already have an account",style: Theme.of(context).textTheme.bodySmall,),
                      TextButton(onPressed: (){
                        Get.offAllNamed(AllRoutes.loginPage);
                      }, child: Text("Login"))
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: (){
                      authController.signUp();
                    },
                    child: Text("Sign Up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
