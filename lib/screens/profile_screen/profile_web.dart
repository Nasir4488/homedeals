import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homedeals/screens/profile_screen/wedgit/User_Properties.dart';
import 'package:homedeals/screens/profile_screen/wedgit/description.dart';
import 'package:homedeals/screens/profile_screen/wedgit/propertiesStatus.dart';
import 'package:homedeals/screens/profile_screen/wedgit/user_information.dart';
import 'package:homedeals/utils/colors.dart';
import 'package:homedeals/wedgits/appbar.dart';
import 'package:homedeals/cores/profile_controller.dart';
import 'package:homedeals/models/profile_model.dart';
import 'package:homedeals/wedgits/fotterSection.dart';

class PropfileScreen_Web extends StatefulWidget {
  const PropfileScreen_Web({Key? key}) : super(key: key);

  @override
  State<PropfileScreen_Web> createState() => _PropfileScreen_WebState();
}

class _PropfileScreen_WebState extends State<PropfileScreen_Web> {

  final profileController = ProfileController();
  final firebaseAuth = FirebaseAuth.instance;

  Future<Profile?> fetchProfileData() async {

    final userId = firebaseAuth.currentUser!.uid;
    final profileData = await profileController.getCurrentUserProfile(userId);
    final profileJson = profileData!['data']['profile'];

    if (profileData != null) {
      return Profile.fromJson(profileJson);
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: FutureBuilder(
        future: fetchProfileData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }
          // Extract profile and property status data
          final Profile profile = snapshot.data!;

          return ListView(
            children: [
              appBarForWeb(context),
              SizedBox(height: 20),
              // Pass profile data to the respective widget
              UserInformation(profile: profile,
              onProfileUpdated: (){
                setState(() {
                  fetchProfileData();
                });
              },
              ),
              SizedBox(height: 20),
              // Pass property status data to the respective widget
              PropertyStatus(),
              SizedBox(height: 30),
              // Pass profile description data
              UserDescription(profile: profile,user: firebaseAuth.currentUser!,onProfileUpdated: (){
                setState(() {
                  fetchProfileData();
                });
              }),
              UserProperties(),
              SizedBox(height: 60),
              Fotter(),
            ],
          );
        },
      ),
    );
  }
}
