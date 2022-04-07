import 'package:flutter/material.dart';
import 'package:quotes_app/screens/all_authors.dart';
import 'package:quotes_app/screens/view_profile.dart';
import 'package:quotes_app/service/profile_service.dart';
import 'package:quotes_app/utils/app_colors.dart';
import 'package:quotes_app/widgets/button_widgets.dart';
import 'package:quotes_app/widgets/textfield_widget.dart';
import 'package:get/get.dart';
import '../model/profile.dart';
import '../utils/toast_message.dart';

class AddProfile extends StatefulWidget {
  AddProfile({Key? key}) : super(key: key);

  final Profile profile = Profile(0, "", "", "");

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();

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
                        int generatedId = profileService
                            .createProfile(widget.profile);
                        debugPrint("add profile successfully");

                          debugPrint(
                              '************** Author List ***************************');
                          debugPrint(profileService
                              .getProfileById(generatedId)
                              .toString());

                        displayMessage(
                            'Profile added successfully!', Colors.green);

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
                    text: "Create ",
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
