import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:take_home/controllers/books_controller.dart';
import 'package:take_home/helpers/responsiveness.dart';
import 'package:take_home/models/book_model.dart';
import 'package:take_home/screens/details/detail_screen.dart';
import 'package:take_home/widgets/book_home_card.dart';
import 'package:take_home/widgets/loading_shimmer.dart';

class BooksStreamList extends StatelessWidget {
  Stream<BookModel> booksStream;
  BooksStreamList({
    Key? key,
    required this.booksStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BookModel>(
        stream: booksStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BookLoadingShimmer();
          }
          if (snapshot.hasError) {
            Fluttertoast.showToast(
              msg: "Somehting went wrong!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 15,
            );
          }
          BookModel booksData = snapshot.data;
          return Responsivness().isSmall(context)
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, indx) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                    imageUrl: booksData.items?[indx].volumeInfo
                                            ?.imageLinks?.smallThumbnail ??
                                        "not found",
                                    title: booksData
                                            .items?[indx].volumeInfo?.title ??
                                        "not found",
                                    averageRating: booksData.items?[indx]
                                            .volumeInfo?.averageRating
                                            .toString() ??
                                        "not found",
                                    author: booksData.items?[indx].volumeInfo
                                                ?.authors ==
                                            null
                                        ? "not found"
                                        : booksData.items?[indx].volumeInfo
                                                    ?.authors?.length ==
                                                0
                                            ? "not found"
                                            : booksData.items?[indx].volumeInfo
                                                    ?.authors?[0] ??
                                                "not found",
                                    description: booksData.items?[indx]
                                            .volumeInfo?.description ??
                                        "not found",
                                    bookid: booksData.items?[indx].id ??
                                        "not found",
                                    book: booksData.items?[indx],
                                    favList: bookIdList,
                                  )),
                        );
                      },
                      child: BookHomeCard(
                        title: booksData.items?[indx].volumeInfo?.title ??
                            "not found",
                        imageUrl: booksData.items?[indx].volumeInfo?.imageLinks
                                ?.smallThumbnail ??
                            "not found",
                        author:
                            booksData.items?[indx].volumeInfo?.authors == null
                                ? "not found"
                                : booksData.items?[indx].volumeInfo?.authors
                                            ?.length ==
                                        0
                                    ? "not found"
                                    : booksData.items?[indx].volumeInfo
                                            ?.authors?[0] ??
                                        "not found",
                        categories:
                            booksData.items?[indx].volumeInfo?.categories ==
                                    null
                                ? "not found"
                                : booksData.items?[indx].volumeInfo?.categories
                                            ?.length ==
                                        0
                                    ? "not found"
                                    : booksData.items?[indx].volumeInfo
                                            ?.categories?[0] ??
                                        "not found",
                        averageRating: booksData
                                .items?[indx].volumeInfo?.averageRating
                                .toString() ??
                            "not found",
                      ),
                    );
                  },
                  itemCount: booksData.items?.length,
                )
              : GridView.builder(
                  itemCount: booksData.items?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsivness().isMedium(context) ? 2 : 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: (2 / 1),
                  ),
                  itemBuilder: (context, indx) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                    imageUrl: booksData.items?[indx].volumeInfo
                                            ?.imageLinks?.smallThumbnail ??
                                        "not found",
                                    title: booksData
                                            .items?[indx].volumeInfo?.title ??
                                        "not found",
                                    averageRating: booksData.items?[indx]
                                            .volumeInfo?.averageRating
                                            .toString() ??
                                        "not found",
                                    author: booksData.items?[indx].volumeInfo
                                                ?.authors ==
                                            null
                                        ? "not found"
                                        : booksData.items?[indx].volumeInfo
                                                    ?.authors?.length ==
                                                0
                                            ? "not found"
                                            : booksData.items?[indx].volumeInfo
                                                    ?.authors?[0] ??
                                                "not found",
                                    description: booksData.items?[indx]
                                            .volumeInfo?.description ??
                                        "not found",
                                    bookid: booksData.items?[indx].id ??
                                        "not found",
                                    book: booksData.items?[indx],
                                    favList: bookIdList,
                                  )),
                        );
                      },
                      child: BookHomeCard(
                        title: booksData.items?[indx].volumeInfo?.title ??
                            "not found",
                        imageUrl: booksData.items?[indx].volumeInfo?.imageLinks
                                ?.smallThumbnail ??
                            "not found",
                        author:
                            booksData.items?[indx].volumeInfo?.authors == null
                                ? "not found"
                                : booksData.items?[indx].volumeInfo?.authors
                                            ?.length ==
                                        0
                                    ? "not found"
                                    : booksData.items?[indx].volumeInfo
                                            ?.authors?[0] ??
                                        "not found",
                        categories:
                            booksData.items?[indx].volumeInfo?.categories ==
                                    null
                                ? "not found"
                                : booksData.items?[indx].volumeInfo?.categories
                                            ?.length ==
                                        0
                                    ? "not found"
                                    : booksData.items?[indx].volumeInfo
                                            ?.categories?[0] ??
                                        "not found",
                        averageRating: booksData
                                .items?[indx].volumeInfo?.averageRating
                                .toString() ??
                            "not found",
                      ),
                    );
                  });
        });
  }
}

// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_is_empty
