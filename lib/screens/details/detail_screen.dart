import 'package:flutter/material.dart';

import 'package:take_home/controllers/books_controller.dart';
import 'package:take_home/helpers/responsiveness.dart';
import 'package:take_home/services/firebase_user_actions.dart';

class DetailScreen extends StatefulWidget {
  String imageUrl;
  String title;
  String averageRating;
  String author;
  String description;
  List favList;
  String bookid;
  dynamic book;

  DetailScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.averageRating,
    required this.author,
    required this.description,
    required this.bookid,
    required this.favList,
    required this.book,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLiked = false;

  @override
  void initState() {
    isLiked = widget.favList.contains(widget.bookid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: Responsivness().isSmall(context)
                    ? 400
                    : Responsivness().isMedium(context)
                        ? 700
                        : 400,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.imageUrl),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.transparent])),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 30,
                    right: 30,
                    bottom: 20,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white60,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Text(
                          "Book name",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.transparent,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.ac_unit,
                          color: Colors.transparent,
                        )
                      ]),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 20,
              right: 20,
              bottom: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text(
                              widget.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Responsivness().isSmall(context)
                                      ? 25
                                      : Responsivness().isMedium(context)
                                          ? 35
                                          : 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "by ${widget.author}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    Responsivness().isMedium(context) ? 22 : 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size:
                                    Responsivness().isMedium(context) ? 30 : 24,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.averageRating == "null"
                                    ? "0"
                                    : widget.averageRating,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Responsivness().isMedium(context)
                                        ? 22
                                        : 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ]),
                    IconButton(
                        onPressed: () {
                          widget.favList.contains(widget.bookid)
                              ? {
                                  FirebaseUserActions()
                                      .removeFromFav(bookid: widget.bookid),
                                  bookIdList.remove(widget.bookid)
                                }
                              : {
                                  FirebaseUserActions()
                                      .addToFav(bookid: widget.bookid),
                                  bookIdList.add(widget.bookid)
                                };

                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        icon: Icon(
                          isLiked
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: isLiked ? Colors.red : Colors.black,
                          size: Responsivness().isMedium(context) ? 32 : 24,
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: Responsivness().isMedium(context) ? 500 : 400,
                  child: Text(
                    widget.description,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Responsivness().isMedium(context) ? 22 : 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

// ignore_for_file: must_be_immutable
