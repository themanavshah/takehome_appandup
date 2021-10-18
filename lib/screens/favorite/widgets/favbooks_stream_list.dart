import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:take_home/controllers/books_controller.dart';
import 'package:take_home/helpers/responsiveness.dart';
import 'package:take_home/models/book_model.dart';
import 'package:take_home/screens/details/detail_screen.dart';
import 'package:take_home/widgets/book_home_card.dart';
import 'package:take_home/widgets/loading_shimmer.dart';

class FavBooksStreamList extends StatelessWidget {
  Stream<List<Book?>> favBooksStream;
  FavBooksStreamList({
    Key? key,
    required this.favBooksStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book?>>(
        stream: favBooksStream,
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
          List<Book?> _books = snapshot.data;
          return _books[0]?.kind != "empty"
              ? Responsivness().isSmall(context)
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, indx) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        imageUrl: _books[indx]
                                                ?.volumeInfo
                                                ?.imageLinks
                                                ?.smallThumbnail ??
                                            "not found",
                                        title:
                                            _books[indx]?.volumeInfo?.title ??
                                                "not found",
                                        averageRating: _books[indx]
                                                ?.volumeInfo
                                                ?.averageRating
                                                .toString() ??
                                            "not found",
                                        author:
                                            _books[indx]?.volumeInfo?.authors ==
                                                    null
                                                ? "not found"
                                                : _books[indx]
                                                            ?.volumeInfo
                                                            ?.authors
                                                            ?.length ==
                                                        0
                                                    ? "not found"
                                                    : _books[indx]
                                                            ?.volumeInfo
                                                            ?.authors?[0] ??
                                                        "not found",
                                        description: _books[indx]
                                                ?.volumeInfo
                                                ?.description ??
                                            "not found",
                                        bookid: _books[indx]?.id ?? "not found",
                                        book: _books[indx],
                                        favList: bookIdList,
                                      )),
                            );
                          },
                          child: BookHomeCard(
                            title:
                                _books[indx]?.volumeInfo?.title ?? "not found",
                            imageUrl: _books[indx]
                                    ?.volumeInfo
                                    ?.imageLinks
                                    ?.smallThumbnail ??
                                "not found",
                            author: _books[indx]?.volumeInfo?.authors == null
                                ? "not found"
                                : _books[indx]?.volumeInfo?.authors?.length == 0
                                    ? "not found"
                                    : _books[indx]?.volumeInfo?.authors?[0] ??
                                        "not found",
                            categories:
                                _books[indx]?.volumeInfo?.categories == null
                                    ? "not found"
                                    : _books[indx]
                                                ?.volumeInfo
                                                ?.categories
                                                ?.length ==
                                            0
                                        ? "not found"
                                        : _books[indx]
                                                ?.volumeInfo
                                                ?.categories?[0] ??
                                            "not found",
                            averageRating: _books[indx]
                                    ?.volumeInfo
                                    ?.averageRating
                                    .toString() ??
                                "not found",
                          ),
                        );
                      },
                      itemCount: _books.length,
                    )
                  : GridView.builder(
                      itemCount: _books.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            Responsivness().isMedium(context) ? 2 : 3,
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
                                        imageUrl: _books[indx]
                                                ?.volumeInfo
                                                ?.imageLinks
                                                ?.smallThumbnail ??
                                            "not found",
                                        title:
                                            _books[indx]?.volumeInfo?.title ??
                                                "not found",
                                        averageRating: _books[indx]
                                                ?.volumeInfo
                                                ?.averageRating
                                                .toString() ??
                                            "not found",
                                        author:
                                            _books[indx]?.volumeInfo?.authors ==
                                                    null
                                                ? "not found"
                                                : _books[indx]
                                                            ?.volumeInfo
                                                            ?.authors
                                                            ?.length ==
                                                        0
                                                    ? "not found"
                                                    : _books[indx]
                                                            ?.volumeInfo
                                                            ?.authors?[0] ??
                                                        "not found",
                                        description: _books[indx]
                                                ?.volumeInfo
                                                ?.description ??
                                            "not found",
                                        bookid: _books[indx]?.id ?? "not found",
                                        book: _books[indx],
                                        favList: bookIdList,
                                      )),
                            );
                          },
                          child: BookHomeCard(
                            title:
                                _books[indx]?.volumeInfo?.title ?? "not found",
                            imageUrl: _books[indx]
                                    ?.volumeInfo
                                    ?.imageLinks
                                    ?.smallThumbnail ??
                                "not found",
                            author: _books[indx]?.volumeInfo?.authors == null
                                ? "not found"
                                : _books[indx]?.volumeInfo?.authors?.length == 0
                                    ? "not found"
                                    : _books[indx]?.volumeInfo?.authors?[0] ??
                                        "not found",
                            categories:
                                _books[indx]?.volumeInfo?.categories == null
                                    ? "not found"
                                    : _books[indx]
                                                ?.volumeInfo
                                                ?.categories
                                                ?.length ==
                                            0
                                        ? "not found"
                                        : _books[indx]
                                                ?.volumeInfo
                                                ?.categories?[0] ??
                                            "not found",
                            averageRating: _books[indx]
                                    ?.volumeInfo
                                    ?.averageRating
                                    .toString() ??
                                "not found",
                          ),
                        );
                      },
                    )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 45,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "No favorites",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                );
        });
  }
}

// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_is_empty
