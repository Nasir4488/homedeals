import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homedeals/cores/profile_controller.dart';
import 'package:homedeals/models/profile_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/textTheams.dart';
import 'package:get/get.dart';
class UserDescription extends StatefulWidget {
 final Profile profile;
 final User user;
 final VoidCallback  onProfileUpdated;


 const UserDescription({Key? key,required this.profile,required this.user,required this.onProfileUpdated}) : super(key: key);

  @override
  State<UserDescription> createState() => _UserDescriptionState();
}
class _UserDescriptionState extends State<UserDescription> {
  bool _isEditing = false; // To track if we are in edit mode
  bool _contactUsEditing=false;//to track contact editing mode
  final profileController = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    profileController.descriptionController.text = widget.profile.description ?? "";
    profileController.phoneController.text = widget.profile.phoneNumber ?? "";
    profileController.mobileController.text = widget.profile.mobile ?? "";
    profileController.addressController.text = widget.profile.address ?? "";
    profileController.officeController.text = widget.profile.office ?? "";
    profileController.faxController.text = widget.profile.faxId ?? "";
    profileController.taxController.text = widget.profile.taxId ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(

      margin: EdgeInsets.symmetric(horizontal:screenWidth*0.1),
      height: 370,
      width: screenWidth,
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 300,
            color: Colors.white,
            padding: EdgeInsets.all(8),
            width: screenWidth*.56,
            child: Stack(
              children: [
                Positioned(bottom: 10,right: 10,
                child: _isEditing?Row(
                  children: [
                    Container(
                        width:100,
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(onPressed: (){
                          _isEditing=false;
                          setState(() {

                          });
                        }, child: Text("Cancel",style: buttontext!.copyWith(color: Colors.white),))),
                    SizedBox(width: 40,),
                    Container(
                        width:100,
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              Profile profile = Profile(
                                userId: widget.user.uid,
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
                                phoneNumber: widget.profile.phoneNumber ?? '', // keep existing phoneNumber
                              );
                              profileController.patchProfile(profile.toJson());
                              _isEditing = false;
                              widget.onProfileUpdated();
                              // Navigator.pop(context);

                            },
                             child: Text("Save",style: buttontext!.copyWith(color: Colors.white),))),

                  ],
                ):IconButton(
                  onPressed: (){
                    _isEditing=true;
                    setState(() {
                      // _descriptionController.text=widget.profile.description!;
                    });
                  },
                  icon: Icon(Icons.edit),
                ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText("About ${widget.user.displayName}",style: Theme.of(context).textTheme.bodyMedium,),
                    SizedBox(height: 20,),
                    _isEditing
                        ? TextField(
                      controller: profileController.descriptionController,

                      maxLines: 6,
                      decoration: textFieldDecoration(context: context),
                      style: subheading,
                    )
                        : AutoSizeText(
                      (widget.profile.description != null &&
                          widget.profile.description!.isNotEmpty)
                          ? widget.profile.description!
                          : "Enter your details",
                      style: subheading,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            width: screenWidth*0.2,
            color: Colors.white,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText("Contact Us",style: subheading!.copyWith(fontWeight: FontWeight.w600),),
                    IconButton(
                      onPressed: () {
                        _contactUsEditing = true;
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text('Enter your Details'),
                            content: SizedBox(
                              height: 300, // Limit the height of the dialog content
                              child: SingleChildScrollView( // Add scrolling if content exceeds height
                                child: Column(
                                  mainAxisSize: MainAxisSize.min, // Ensure the column respects its constraints
                                  children: [
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        enabled: false,
                                        controller: profileController.phoneController,
                                        decoration: textFieldDecoration(
                                            context: context, hint: "Phone"),
                                        style: profileText,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: profileController.mobileController,
                                        decoration: textFieldDecoration(
                                            context: context, hint: "Mobile"),
                                        style: profileText,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: profileController.addressController,
                                        decoration: textFieldDecoration(
                                            context: context, hint: "Address"),
                                        style: profileText,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: profileController.officeController,
                                        decoration: textFieldDecoration(
                                            context: context, hint: "Office"),
                                        style: profileText,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: profileController.faxController,
                                        decoration: textFieldDecoration(
                                            context: context, hint: "Fax Number"),
                                        style: profileText,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: profileController.taxController,
                                        decoration: textFieldDecoration(
                                            context: context, hint: "Tax Number"),
                                        style: profileText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: Text(
                                  'Cancel',
                                  style: buttontext!.copyWith(color: blueColor),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Profile profile = Profile(
                                    userId: widget.user.uid,
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
                                    phoneNumber: widget.profile.phoneNumber ?? '', // keep existing phoneNumber
                                  );
                                  profileController.patchProfile(profile.toJson());
                                  _isEditing = false;
                                  widget.onProfileUpdated();
                                  Navigator.pop(context);
                                },

                                child: Text(
                                  'OK',
                                  style: buttontext!.copyWith(color: blueColor),
                                ),
                              ),
                            ],
                          ),
                        );
                        setState(() {});
                      },
                      icon: Icon(Icons.edit, size: 16),
                    ),
                  ],
                ),
                Divider(),
                AutoSizeText("Bucharest,Sector 6, Regie ",style: Theme.of(context).textTheme.bodySmall,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText("Phone", style: subheading!.copyWith(fontWeight: FontWeight.w600)),
                    AutoSizeText(
                      widget.profile.phoneNumber != null && widget.profile.phoneNumber!.isNotEmpty
                          ? widget.profile.phoneNumber!
                          : profileController.phoneController.text.isNotEmpty
                          ? profileController.phoneController.text
                          : "Phone Number",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),

                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText("Mobile", style: subheading!.copyWith(fontWeight: FontWeight.w600)),
                    AutoSizeText(
                      widget.profile.mobile != null && widget.profile.mobile!.isNotEmpty
                          ? widget.profile.mobile!
                          : profileController.mobileController.text.isNotEmpty
                          ? profileController.mobileController.text
                          : "Mobile Number",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText("Fax", style: subheading!.copyWith(fontWeight: FontWeight.w600)),
                    AutoSizeText(
                      widget.profile.faxId != null && widget.profile.faxId!.isNotEmpty
                          ? widget.profile.faxId!
                          : profileController.faxController.text.isNotEmpty
                          ? profileController.faxController.text
                          : "Fax Number",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                  ],
                ),


                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText("Tax", style: subheading!.copyWith(fontWeight: FontWeight.w600)),
                    AutoSizeText(
                      widget.profile.taxId != null && widget.profile.taxId!.isNotEmpty
                          ? widget.profile.taxId!
                          : profileController.taxController.text.isNotEmpty
                          ? profileController.taxController.text
                          : "Tax Number",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                  ],
                ),

                Divider(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
