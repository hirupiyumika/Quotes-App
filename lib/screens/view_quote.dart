import 'package:flutter/material.dart';
import 'package:quotes_app/model/quote.dart';
import 'package:quotes_app/screens/add_author.dart';
import 'package:quotes_app/screens/all_authors.dart';
import 'package:quotes_app/screens/edit_author.dart';
import 'package:quotes_app/screens/edit_quote.dart';
import 'package:quotes_app/screens/home_screen.dart';
import 'package:quotes_app/utils/app_colors.dart';
import 'package:quotes_app/widgets/author_widget.dart';
import 'package:quotes_app/widgets/button_widgets.dart';
import 'package:get/get.dart';
import '../utils/toast_message.dart';
import '../model/author.dart';
import '../service/author_service.dart';
import '../widgets/textfield_widget.dart';

class ViewQuote extends StatelessWidget {
  ViewQuote({Key? key, required this.author}) : super(key: key);

  final Author author;
  // final List<Author> authorsList = AuthorService.getInstance().getAll();
  // final Quote quote = Quote();

  @override
  Widget build(BuildContext context) {
    List myData = ["The greatest glory in living lies not in never falling, but in rising every time we fall. -Nelson Mandela", "The way to get started is to quit talking and begin doing. -Walt Disney"];
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF2e3253).withOpacity(0.5),
      child: const Icon(Icons.edit, color: Colors.white),
      alignment: Alignment.centerLeft,
    );
    final rightDeleteIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.redAccent,
      child: const Icon(Icons.delete, color: Colors.white),
      alignment: Alignment.centerRight,
    );
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 60,
                top: 40,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 3.2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/3.jpg",
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => HomeScreen(),
                          transition: Transition.zoom,
                          duration: const Duration(microseconds: 500));
                    },
                    child: Icon(
                      Icons.home,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.5),
                      color: Colors.black,
                    ),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.article_sharp,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "2",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: author.quotes.length,
                // itemCount: myData.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: leftEditIcon,
                    secondaryBackground: rightDeleteIcon,
                    confirmDismiss: (DismissDirection direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (_) {
                            return Container(
                              height: 300,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF2e3253).withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => AddAuthor(),
                                            transition: Transition.fade,
                                            duration: const Duration(seconds: 1));
                                      },
                                      child: ButtonWedget(
                                        backgroundcolor: AppColors.mainColor,
                                        text: "Add",
                                        textColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => EditQuote(author: author, quoteIndex: index,),
                                            transition: Transition.fade,
                                            duration: const Duration(seconds: 1));
                                      },
                                      child: ButtonWedget(
                                        backgroundcolor: AppColors.mainColor,
                                        text: "Edit",
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        return false;
                      } else {
                        // return Future.delayed(Duration(seconds: 1),
                        //     () => direction == DismissDirection.endToStart);
                                                showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (_) {
                            return Container(
                              height: 300,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF2e3253).withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        debugPrint('Click on delete button');
                                        try {
                                          // AuthorService authorService = AuthorService.getInstance();
                                          // authorService.deleteAuthorById(authorsList[index].id);
                                          // debugPrint(
                                          //     "Author deleted successfully");

                                          // debugPrint(
                                          //     '************** Quote List ***************************');
                                          // authorService.getAll().forEach(
                                          //     (Author author) =>
                                          //         debugPrint(author.toString()));
                                          // displayMessage(
                                          //     "Author deleted successfully",
                                          //     Colors.red);
                                          // Get.to(() => const AllAuthors(),
                                          //     transition: Transition.zoom,
                                          //     duration: const Duration(microseconds: 500));
                                        } catch (e) {
                                          // debugPrint(e.toString());
                                          displayMessage(
                                              'Error: something went wrong!',
                                              Colors.red);
                                        }
                                        Get.to(() => AllAuthors(),
                                            transition: Transition.zoom,
                                            duration: const Duration(
                                                microseconds: 500));
                                      },
                                      child: ButtonWedget(
                                        backgroundcolor: AppColors.mainColor,
                                        text: "Delete",
                                        textColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => AllAuthors(),
                                            transition: Transition.fade,
                                            duration:
                                                const Duration(seconds: 1));
                                      },
                                      child: ButtonWedget(
                                        backgroundcolor: AppColors.mainColor,
                                        text: "No",
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    onDismissed: (DismissDirection direction) {
                      print("after confernming");
                    },
                    key: ObjectKey(index),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child:
                      AuthorWediget(
                          text: author.quotes.elementAt(index).quote,
                        // text: myData[index],
                        color: Colors.blueGrey,
                      ),
                      // TextfieldWidget(
                      //     textController: author.quotes.elementAt(index).quote,
                      //     hintText: "Write the quote...",
                      //     borderRadius: 15,
                      //     maxLines: 4),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
