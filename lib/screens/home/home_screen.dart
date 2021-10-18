import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:take_home/controllers/books_controller.dart';
import 'package:take_home/helpers/responsiveness.dart';
import 'package:take_home/screens/home/widgets/books_stream_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  var _searchName = "Famous Books";

  BooksController booksController = BooksController();
  bool isSearchLoading = false;

  @override
  void initState() {
    booksController.eventSink.add({
      "event": userActions.getBooks,
      "search name": _searchName,
    });
    super.initState();
  }

  @override
  void dispose() {
    booksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 85,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: const Text(
                                "Explore thousands of books on the go",
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 10,
                                blurRadius: 25,
                                offset: const Offset(
                                    0, 7), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(80),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: TextFormField(
                                      autocorrect: false,
                                      cursorColor: Colors.orange,
                                      controller: _searchController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: "Search for books",
                                        fillColor: Colors.black,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          Fluttertoast.showToast(
                                            msg: "Empty field!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 15,
                                          );
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (_searchController.text.isNotEmpty) {
                                          booksController.eventSink.add({
                                            "event": userActions.getBooks,
                                            "search name":
                                                _searchController.text,
                                          });
                                          setState(() {
                                            _searchName =
                                                _searchController.text;
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              _searchName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: Responsivness().isSmall(context) ? 0 : 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ];
      },
      body: BooksStreamList(booksStream: booksController.booksStream),
    );
  }
}
