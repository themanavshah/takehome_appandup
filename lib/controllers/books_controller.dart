import 'dart:async';

import 'package:take_home/models/book_model.dart';
import 'package:take_home/services/books_api_service.dart';

enum userActions {
  getBooks,
}

class BooksController {
  final _stateStreamController = StreamController<BookModel>.broadcast();
  StreamSink<BookModel> get _booksSink => _stateStreamController.sink;
  Stream<BookModel> get booksStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<Map<String, dynamic>>();
  StreamSink<Map<String, dynamic>> get eventSink => _eventStreamController.sink;
  Stream<Map<String, dynamic>> get _eventStream =>
      _eventStreamController.stream;

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }

  BooksController() {
    _eventStream.listen((event) async {
      if (event["event"] == userActions.getBooks) {
        try {
          BookModel books =
              await BooksApi().getBooks(name: event["search name"]);
          _booksSink.add(books);
        } on Exception catch (error) {
          print(error);
          _booksSink.addError('Something went wrong!');
        }
      } else {
        print("eventSink is not used properly.");
      }
    });
  }
}

final bookIdList = [];
