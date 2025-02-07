
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:homedeals/cores/profile_controller.dart';
import 'package:homedeals/models/profile_model.dart';
import 'package:homedeals/screens/home_screen/home_screen.dart';
import 'package:homedeals/utils/routes.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  var box = Hive.box("user");
  final ProfileController profileController=ProfileController();

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        // The user is signed in
        String? jwt = await user.getIdToken(true);
        await _saveJwt(jwt!);
        // decodeJwt(jwt!);
        // print('New JWT: $jwt!');
      } else {
        // The user is signed out
        print('User signed out');
      }
    });
  }

  Future<void> _saveUserData(String name, String email) async {
    await box.put('userName', name);
    await box.put('userEmail', email);
  }

  Future<void> _saveJwt(String jwt) async {
    await box.put('jwt', jwt);
  }

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please provide email and password");
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? jwt = await userCredential.user!.getIdToken();
      User? user = userCredential.user;
      if (user != null) {
        String? name = user.displayName ?? 'No Name';
        String email = user.email ?? 'No Email';
        await _saveUserData(name, email);
        await _saveJwt(jwt!);
        Get.snackbar("Success", "Login successful");
        Profile profile=Profile(userId: _auth.currentUser!.uid,);
        profileController.postProfile(profile.toJson());
        Get.toNamed(AllRoutes.homePage);
        // decodeJwt(jwt);
        print(jwt!);
      } else {
        Get.snackbar("Error", "Login failed");
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';

          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
        default:
          message = 'An unknown error occurred.';
      }
      Get.snackbar("Error", message);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // void decodeJwt(String token) {
  //   // Check if the token is expired
  //   bool isTokenExpired = JwtDecoder.isExpired(token);
  //   print('Is token expired? $isTokenExpired');
  //
  //   // Get the expiration date
  //   DateTime expirationDate = JwtDecoder.getExpirationDate(token);
  //   print('Token expiration date: $expirationDate');
  //
  //   // Decode the token
  //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //
  //   // Print the decoded payload
  //   print('Decoded Token: $decodedToken');
  //
  //   // Example: Access specific claims
  //   String userId = decodedToken['user_id'];
  //   print('User ID: $userId');
  // }
}
