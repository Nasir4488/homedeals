import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/cores/profile_controller.dart';
import 'package:homedeals/models/profile_model.dart';
import 'package:homedeals/screens/auth/login.dart';
import 'package:homedeals/utils/colors.dart';
import 'package:homedeals/utils/textTheams.dart';

class UserInformation extends StatefulWidget {
  final Profile profile;
  final VoidCallback  onProfileUpdated;
  const UserInformation({Key? key,required this.profile,required this.onProfileUpdated}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  var profileController = Get.put(ProfileController());
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isLoading = true; // Loading indicator for async operation


  @override
  void initState() {
    profileController.phoneController.text=widget.profile.phoneNumber ?? "";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var screen_height = MediaQuery.of(context).size.height;
    var screen_width = MediaQuery.of(context).size.width;

    return  Container(
      margin: EdgeInsets.symmetric(horizontal: screen_width * .1),
      color: Colors.white,
      height: 400,
      width: screen_width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(right: 30, top: 30, child: Icon(Icons.edit)),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.grey.shade100.withOpacity(0.6),
                      height: 320,
                      margin: EdgeInsets.all(20),
                      width: screen_width * .26,
                      child: firebaseAuth.currentUser!.photoURL != null
                          ? Image.network("${firebaseAuth.currentUser!.photoURL}",
                          fit: BoxFit.fill)
                          : Image.asset(
                          'assets/images/man.png'), // Replace with a default image
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "${firebaseAuth.currentUser!.displayName}",
                          style: mediamheading,
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              "4.6    ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            AutoSizeText("See All Reviews",
                                style: profileText!.copyWith(color: Colors.blue)),
                          ],
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              "Company Agent At   ",
                              style: profileText!.copyWith(color: Colors.black),
                            ),
                            AutoSizeText("Modren House Real Estate",
                                style: profileText!.copyWith(color: Colors.blue)),
                          ],
                        ),
                        SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                AutoSizeText(
                                  "Phone Number:   ",
                                  style: textmediam!.copyWith(color: Colors.black),
                                ),
                                AutoSizeText(
                                  widget.profile.phoneNumber==null?"ppp":widget.profile.phoneNumber!,
                                  style: profileText,
                                ),

                              ],
                            ),
                            IconButton(
                              hoverColor: blueColor,
                              tooltip: "Edit phone Number",
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text('Enter your Phone Number'),
                                    content: Container(
                                        height: 50,
                                        child: TextField(
                                            controller: profileController.phoneController,
                                            decoration: textFieldDecoration(
                                                context: context, hint: "phone"),
                                            style: profileText)),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: Text(
                                          'Cancel',
                                          style: buttontext!
                                              .copyWith(color: blueColor),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Profile profile = Profile(
                                            userId: widget.profile.userId,
                                            description: profileController.descriptionController.text.isNotEmpty
                                                ? profileController.descriptionController.text
                                                : widget.profile.description ?? '', // retain old value if not updated
                                            address: profileController.addressController.text.isNotEmpty
                                                ? profileController.addressController.text
                                                : widget.profile.address ?? '',
                                            taxId: profileController.taxController.text.isNotEmpty
                                                ? profileController.taxController.text
                                                : widget.profile.taxId ?? '',
                                            faxId: profileController.faxController.text.isNotEmpty
                                                ? profileController.faxController.text
                                                : widget.profile.faxId ?? '',
                                            mobile: profileController.mobileController.text.isNotEmpty
                                                ? profileController.mobileController.text
                                                : widget.profile.mobile ?? '',
                                            office: profileController.officeController.text.isNotEmpty
                                                ? profileController.officeController.text
                                                : widget.profile.office ?? '',
                                            phoneNumber: profileController.phoneController.text ?? '', // keep existing phoneNumber
                                          );
                                          profileController.patchProfile(profile.toJson());
                                          widget.onProfileUpdated();
                                          Navigator.pop(context);

                                        },

                                        child: Text(
                                          'OK',
                                          style: buttontext!
                                              .copyWith(color: blueColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Container(
                                width: 100,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    onPressed: () {
                                      Get.to(LoginScreen());
                                    },
                                    child: Text(
                                      "Email",
                                      style: buttontext!
                                          .copyWith(color: Colors.white),
                                    ))),
                            SizedBox(width: 7),
                            Container(
                                width: 100,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      elevation: 1000,
                                    ),
                                    onPressed: () {},
                                    child: Text("Call"))),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
      ),
    );
  }
}
