import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/cores/authController/loginController.dart';
import 'package:homedeals/utils/colors.dart';
import '../../utils/textTheams.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginController=Get.put(LoginController());
  @override
  final _loginformKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loginController.check();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _loginformKey,
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
              children: [
                TextFormField(
                  controller: loginController.emailController,
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
                SizedBox(height: 20,),

                TextFormField(
                  controller: loginController.passwordController,
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
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Don't have an account?", style: Theme.of(context).textTheme.bodySmall),
                      TextButton(
                        onPressed: () {

                          // Get.offAllNamed(AllRoutes.signupScreen);
                        },
                        child: Text("Sign Up"),

                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: ()async {
                      if (_loginformKey.currentState!.validate()) {
                        loginController.login();
                      }                  },
                    child: Text("Login"),
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
