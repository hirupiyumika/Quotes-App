import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/screens/view_profile.dart';
import 'package:quotes_app/service/profile_service.dart';
import 'package:quotes_app/utils/app_colors.dart';
import 'package:quotes_app/widgets/button_widgets.dart';
import 'package:quotes_app/widgets/textfield_widget.dart';

import '../model/profile.dart';
import '../utils/toast_message.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);

  Profile profile = Profile(0, "dfasdfadf", "", "");

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  final ProfileService _profileService = ProfileService.getInstance();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Profile? profileRecord = _profileService.getProfileById(1);
    if(profileRecord != null){
      debugPrint('PrintRecord instance:');
      // debugPrint(profileRecord.toString());
      widget.profile = profileRecord;
      debugPrint( widget.profile.toString());
    }

    _nameController.text = widget.profile.name;
    _emailController.text = widget.profile.email;
    _contactController.text = widget.profile.contactNo;

    _nameController.addListener(() {
      final String name = _nameController.text;
      debugPrint('nameTxtField: $name');
      widget.profile.name = name.trim();
    });

    _emailController.addListener(() {
      final String email = _emailController.text;
      debugPrint('email: $email');
      widget.profile.email = email.trim();
    });

    _contactController.addListener(() {
      final String contactNo = _contactController.text;
      debugPrint('contactNo: $contactNo');
      widget.profile.contactNo = contactNo.trim();
    });

  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

// validation
  bool doValidation() {
    return !(widget.profile.name.isEmpty &&
        widget.profile.email.isEmpty &&
        widget.profile.contactNo.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/2.jpg",
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30.0,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 20),
                TextfieldWidget(
                  textController: _nameController,
                  hintText: "Name",
                ),
                const SizedBox(height: 20),
                TextfieldWidget(
                  textController: _emailController,
                  hintText: "Email",
                ),
                const SizedBox(height: 20),
                TextfieldWidget(
                  textController: _contactController,
                  hintText: "Contact",
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    debugPrint('Click on add button');
                    debugPrint('Profile entity details: ');
                    ProfileService profileService =
                        ProfileService.getInstance();

                    try {
                      if (doValidation()) {
                        profileService.updateProfile(widget.profile);
                        debugPrint("profile update successfully");

                        debugPrint(
                            '************** Profile List ***************************');
                        debugPrint(profileService
                            .getProfileById(widget.profile.id)
                            .toString());
                        displayMessage(
                            'Profile update successfully!', Colors.green);

                        Get.to(() => ViewProfile(),
                            transition: Transition.zoom,
                            duration: const Duration(microseconds: 500));
                      } else {
                        displayMessage('Please fill every field', Colors.red);
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                      displayMessage(
                          'Error: something went wrong!', Colors.red);
                    }
                  },
                  child: ButtonWedget(
                    backgroundcolor: AppColors.mainColor,
                    text: "Update Profile ",
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
          ],
        ),
      ),
    );
  }
}
