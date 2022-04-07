import 'package:flutter/material.dart';
import 'package:quotes_app/screens/all_authors.dart';
import 'package:quotes_app/utils/app_colors.dart';
import 'package:quotes_app/widgets/button_widgets.dart';
import 'package:quotes_app/widgets/textfield_widget.dart';
import 'package:get/get.dart';
import '../model/author.dart';
import '../service/author_service.dart';
import '../utils/toast_message.dart';
import '../model/quote.dart';
import '../service/quote_service.dart';

class AddAuthor extends StatefulWidget {
  AddAuthor({Key? key}) : super(key: key);

  // final Author quote = Author.name(status: 'deactive');
  final Author author = Author();
  final Quote quote = Quote();

  @override
  State<AddAuthor> createState() => _AddAuthorState();
}

class _AddAuthorState extends State<AddAuthor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      final String author = _nameController.text;
      debugPrint('AuthorNameTextField: $author');
      widget.author.name = author.trim();

      // setState(() {
      //   isValid = _isInputValid();
      // });
    });

    _detailController.addListener(() {
      final String quote = _detailController.text;
      debugPrint('QuoteTextField: $quote');
      widget.quote.quote = quote.trim();

      // setState(() {
      //   isValid = _isInputValid();
      // });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _nameController.dispose();
    _detailController.dispose();
    super.dispose();
  }

// validation
  bool doValidation() {
    return !(widget.author.name.isEmpty && widget.quote.quote.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController _nameController = TextEditingController();
    // TextEditingController _detailController = TextEditingController();
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
                TextfieldWidget(
                    textController: _detailController,
                    hintText: "Write the quote...",
                    borderRadius: 15,
                    maxLines: 4),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    debugPrint('Click on add button');
                    try {
                      final AuthorService authorService =
                          AuthorService.getInstance();
                      // Author quote = Author(0, "Hello", "My quote", "true");
                      Author author = widget.author;

                      // adding quotes.
                      author.quotes.add(widget.quote);
                      debugPrint('Auther entity details: ');
                      debugPrint(author.toString());
                      if (doValidation()) {
                        authorService.createAuthor(author);
                        debugPrint("add author successfully");
                        Get.to(() => AllAuthors(),
                            transition: Transition.zoom,
                            duration: const Duration(microseconds: 500));
                      } else {
                        displayToastMessage(
                            'Please fill every field', Colors.red);
                      }

                      debugPrint(
                          '************** Author List ***************************');
                      authorService.getAll().forEach(
                          (Author quote) => debugPrint(quote.toString()));
                      displayToastMessage(
                          'Author added successfully!', Colors.green);
                    } catch (e) {
                      debugPrint(e.toString());
                      displayToastMessage(
                          'Error: something went wrong!', Colors.red);
                    }
                  },
                  child: ButtonWedget(
                    backgroundcolor: AppColors.mainColor,
                    text: "Add",
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
