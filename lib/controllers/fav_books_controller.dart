import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:take_home/models/book_model.dart';
import 'package:take_home/services/books_api_service.dart';

enum userFavActions { likeBook, dislikeBook, getFavBook }

class FavBooksController {
  final _stateStreamController = StreamController<List<Book?>>.broadcast();
  StreamSink<List<Book?>> get _favBooksSink => _stateStreamController.sink;
  Stream<List<Book?>> get favBooksStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<Map<String, dynamic>>();
  StreamSink<Map<String, dynamic>> get eventSink => _eventStreamController.sink;
  Stream<Map<String, dynamic>> get _eventStream =>
      _eventStreamController.stream;

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }

  FavBooksController() {
    _eventStream.listen((event) async {
      if (event["event"] == userFavActions.getFavBook) {
        try {
          FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots()
              .listen((data) {
            List _booksId = data.data()?["favorites"] ?? [];
            List<Book?> _books = [];
            int counter = 0;
            if (_booksId.isEmpty) {
              _favBooksSink.add([Book(kind: "empty")]);
            } else {
              _booksId.forEach((bookid) async {
                BookModel book = await BooksApi().getBooks(name: bookid);
                for (var element in book.items!) {
                  if (element.id == bookid) {
                    _books.add(element);
                    counter++;
                  }
                }

                if (counter == _booksId.length) {
                  _favBooksSink.add(_books);
                }
              });
            }
          });
        } on Exception catch (e) {
          _favBooksSink.addError("something went wrong!");
        }
      } else {
        print("eventSink is used in wrong way.");
      }
    });
  }
}

// ignore_for_file: avoid_function_literals_in_foreach_calls


