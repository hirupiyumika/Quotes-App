import 'package:flutter/material.dart';
import 'package:quotes_app/screens/all_authors.dart';
import 'package:quotes_app/service/author_service.dart';
import 'package:quotes_app/utils/app_colors.dart';
import 'package:quotes_app/widgets/button_widgets.dart';
import 'package:quotes_app/widgets/textfield_widget.dart';
import 'package:get/get.dart';
import '../model/author.dart';
import '../utils/toast_message.dart';
import '../model/quote.dart';
import '../service/quote_service.dart';

class EditAuthor extends StatefulWidget {
  EditAuthor({Key? key, required this.author}) : super(key: key);
  final AuthorService authorService = AuthorService.getInstance();
  final Author author;

  // final Quote quote = Quote.name(status: 'deactive');

  @override
  State<EditAuthor> createState() => _EditAuthorState();
}

class _EditAuthorState extends State<EditAuthor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.author.name;

    _nameController.addListener(() {
      final String authorName = _nameController.text;
      debugPrint('AuthorNameTextField: $authorName');
      widget.author.name = authorName.trim();

      // setState(() {
      //   isValid = _isInputValid();
      // });
    });

    // _detailController.addListener(() {
    //   final String quote = _nameController.text;
    //   debugPrint('QuoteTextField: $quote');
    //   widget.quote.quote = quote.trim();
    //
    //   // setState(() {
    //   //   isValid = _isInputValid();
    //   // });
    // });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailController.dispose();
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
                TextfieldWidget(
                  textController: _nameController,
                  hintText: "Author Name",
                ),
                const SizedBox(height: 20),
                // TextfieldWidget(
                //     textController: _detailController,
                //     hintText: "Write the quote...",
                //     borderRadius: 15,
                //     maxLines: 4),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    debugPrint('Click on add button');
                    try {
                      Author author = widget.author;
                      widget.authorService.updateAuthor(author);
                      debugPrint("Edit author succesfully");

                      debugPrint(
                          '************** Quote List ***************************');
                      widget.authorService.getAll().forEach(
                          (Author author) => debugPrint(author.toString()));
                      displayToastMessage(
                          'Quote Author successfully!', Colors.green);
                    } catch (e) {
                      debugPrint(e.toString());
                      displayToastMessage(
                          'Error: something went wrong!', Colors.red);
                    }
                    Get.to(() => AllAuthors(),
                        transition: Transition.zoom,
                        duration: const Duration(microseconds: 500));
                  },
                  child: ButtonWedget(
                    backgroundcolor: AppColors.mainColor,
                    text: "Save",
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 8),
          ],
        ),
      ),
    );
  }
}
