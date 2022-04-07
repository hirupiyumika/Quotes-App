import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/service/profile_service.dart';

import '../model/profile.dart';
import '../widgets/author_widget.dart';

class ViewProfile extends StatefulWidget {
  ViewProfile({Key? key}) : super(key: key);

  Profile profile = Profile(0, "", "", "");

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {

  final ProfileService _profileService = ProfileService.getInstance();

  @override
  void initState() {
    super.initState();

    Profile? profileRecord = _profileService.getProfileById(1);
    if(profileRecord != null){
      widget.profile = profileRecord;
    }
  }

  @override
  void dispose() {
    super.dispose();
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
                // TextfieldWidget(
                //   textController: _nameController,
                //   hintText: "Name",
                // ),
                AuthorWediget(
                  text: widget.profile.name,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 20),
                // TextfieldWidget(
                //   textController: _emailController,
                //   hintText: "Email",
                // ),
                AuthorWediget(
                  text: widget.profile.email,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 20),
                // TextfieldWidget(
                //   textController: _contactController,
                //   hintText: "Contact",
                // ),
                AuthorWediget(
                  text: widget.profile.contactNo,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 20),
                // InkWell(
                //   onTap: () {
                //   },
                // ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
          ],
        ),
      ),
    );
  }
}
