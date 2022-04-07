import 'package:flutter/material.dart';
import 'package:quotes_app/model/quote.dart';
import 'package:quotes_app/screens/edit_author.dart';
import 'package:quotes_app/screens/view_quote.dart';
import 'package:quotes_app/utils/app_colors.dart';
import 'package:quotes_app/widgets/author_widget.dart';
import 'package:quotes_app/widgets/button_widgets.dart';
import 'package:get/get.dart';
import '../model/author.dart';
import '../service/author_service.dart';
import '../service/quote_service.dart';
import '../utils/toast_message.dart';

class AllAuthors extends StatelessWidget {
  AllAuthors({Key? key}) : super(key: key);

  final List<Author> authorsList = AuthorService.getInstance().getAll();

  @override
  Widget build(BuildContext context) {
    // List myData = ["Hiruni", "Piyumika"];

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
                  Icon(
                    Icons.home,
                    color: AppColors.secondaryColor,
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
                itemCount: authorsList.length,
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
                                        Get.to(
                                            () => ViewQuote(
                                                author: authorsList[index]),
                                            transition: Transition.fade,
                                            duration:
                                                const Duration(seconds: 1));
                                      },
                                      child: ButtonWedget(
                                        backgroundcolor: AppColors.mainColor,
                                        text: "View",
                                        textColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                            () => EditAuthor(
                                                author: authorsList[index]),
                                            transition: Transition.fade,
                                            duration:
                                                const Duration(seconds: 1));
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
                        // return Future.delayed(const Duration(seconds: 1),
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
                                        debugPrint('Click on add button');
                                        try {
                                          final QuoteService quoteService =
                                              QuoteService.getInstance();
                                          // Quote quote = Quote(0, "Hello", "My quote", "true");
                                          // quoteService.createQuote(quote);
                                          quoteService.deleteQuoteById(1);
                                          debugPrint(
                                              "delete quote succesfully");

                                          debugPrint(
                                              '************** Quote List ***************************');
                                          quoteService.getAll().forEach(
                                              (Quote quote) =>
                                                  debugPrint(quote.toString()));
                                          displayToastMessage(
                                              'Quote added successfully!',
                                              Colors.green);
                                        } catch (e) {
                                          debugPrint(e.toString());
                                          displayToastMessage(
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
                      child: AuthorWediget(
                        text: authorsList[index].name,
                        color: Colors.blueGrey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
